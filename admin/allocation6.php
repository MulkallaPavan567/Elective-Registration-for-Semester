<?php
session_start();
include('includes/config.php');

if (strlen($_SESSION['alogin']) == 0) {
    header('location:index.php');
    exit; // Exit script after redirection
}

// Allocate optional cores
if (isset($_POST['submit'])) {
    $streamId = $_POST['stream_idx'];

    // Check if the column enrolment_status_OptionalCore exists in the students table
    $result = mysqli_query($con, "SHOW COLUMNS FROM students WHERE Field = 'enrolment_status_OptionalCore'");
    if (!$result || mysqli_num_rows($result) == 0) {
        echo "Column 'enrolment_status_OptionalCore' does not exist in the students table. Please check your database schema.";
        exit;
    }

    $sql = mysqli_query($con, "SELECT s.studentRegno, s.course_name, s.optional_core_choice_1, s.optional_core_choice_2, s.optional_core_choice_3, s.optional_core_choice_4, s.optional_core_choice_5, st.stream_name
                                FROM students s
                                INNER JOIN stream st ON s.course_name = st.stream_name
                                WHERE s.stream_id = '$streamId' AND s.enrolment_status_OptionalCore = 0
                                ORDER BY s.cgpa DESC");
    if (!$sql) {
        echo "Error in SQL query: " . mysqli_error($con);
        exit;
    }

    while ($row = mysqli_fetch_array($sql)) {
        $choices = array($row['optional_core_choice_1'], $row['optional_core_choice_2'], $row['optional_core_choice_3'], $row['optional_core_choice_4'], $row['optional_core_choice_5']);

        foreach ($choices as $choice) {
            if ($choice != NULL && $choice != "NULL") {
                $courseName = mysqli_real_escape_string($con, $choice);
                $studentRegNo = mysqli_real_escape_string($con, $row['studentRegno']);
                $streamName = mysqli_real_escape_string($con, $row['stream_name']);

                $sqlInsert = "INSERT INTO courses_allocated (courseName, student_reg_no, stream_name, course_type)
                                VALUES ('$courseName', '$studentRegNo', '$streamName', 'Optional Core')";

                if (!mysqli_query($con, $sqlInsert)) {
                    echo "Error in allocating course: " . mysqli_error($con);
                    exit; // Exit loop if error occurs
                }
            }
        }
        // Update enrolment status
        $sqlUpdate = "UPDATE students SET enrolment_status_OptionalCore = 1 WHERE studentRegno = '{$row['studentRegno']}'";
        if (!mysqli_query($con, $sqlUpdate)) {
            echo "Error in updating enrolment status: " . mysqli_error($con);
            exit; // Exit loop if error occurs
        }
    }
    // Remove duplicate values
    $sqlDeleteDuplicate = "DELETE FROM courses_allocated 
                           WHERE courses_allocated_id NOT IN (
                                SELECT MIN(courses_allocated_id)
                                FROM courses_allocated
                                GROUP BY student_reg_no, courseName
                           )";
    if (!mysqli_query($con, $sqlDeleteDuplicate)) {
        echo "Error in removing duplicate values: " . mysqli_error($con);
        exit;
    }
    echo "<script>alert('Optional cores allocated.')</script>";
    header('Refresh:0; URL=http://localhost/electives/onlinecourse/admin/allocation.php');
    exit; // Exit script after redirection
}

// Allocate electives
if (isset($_POST['submitElective'])) {
    // Check if stream_idx is set in the POST data
    if (!isset($_POST['stream_idx'])) {
        die("Stream ID not provided.");
    }

    $streamId = $_POST['stream_idx'];

    // Fetching total number of electives for the stream from set_oc_electives table
    $sqlElectiveCount = mysqli_query($con, "SELECT electives FROM set_oc_electives WHERE stream_id = '$streamId'");

    // Check for errors
    if (!$sqlElectiveCount) {
        // Query execution failed, display error and stop script execution
        die("Query failed: " . mysqli_error($con));
    }

    $rowElectiveCount = mysqli_fetch_assoc($sqlElectiveCount);

    // Check if elective count result is fetched
    if (!$rowElectiveCount) {
        die("No elective count found for stream ID: $streamId");
    }

    $totalElectivesAllowed = $rowElectiveCount['electives'];

    // Fetching all students who haven't been allocated electives yet
    $sqlStudents = mysqli_query($con, "SELECT s.*, st.stream_name 
                                        FROM students s 
                                        INNER JOIN stream st ON s.course_name = st.stream_name 
                                        WHERE s.stream_id = '$streamId' AND s.enrolment_status_elective = 0 
                                        ORDER BY s.cgpa DESC");

    // Check for errors
    if (!$sqlStudents) {
        // Query execution failed, display error and stop script execution
        die("Query failed: " . mysqli_error($con));
    }

    // Loop through each student to allocate electives
    while ($rowStudent = mysqli_fetch_assoc($sqlStudents)) {
        $studentRegNo = $rowStudent['studentRegno'];
        $streamName = $rowStudent['stream_name'];

        // Fetching the elective preferences of the student
        $electivePrefs = array_slice($rowStudent, 2); // Extract elective preferences from the row

        // Array to store selected electives
        $selectedElectives = array();

        // Loop through each preference of the student
        foreach ($electivePrefs as $prefCourseName) {
            // Check if the preference is not NULL
            if ($prefCourseName != NULL && $prefCourseName != "NULL" && count($selectedElectives) < $totalElectivesAllowed) {
                // Checking if elective is already allocated to another student
                $sqlAllocated = mysqli_query($con, "SELECT * FROM courses_allocated WHERE courseName = '$prefCourseName' AND stream_name = '$streamName'");

                // Check for errors
                if (!$sqlAllocated) {
                    // Query execution failed, display error and stop script execution
                    die("Query failed: " . mysqli_error($con));
                }

                if (mysqli_num_rows($sqlAllocated) == 0) {
                    $courseName = mysqli_real_escape_string($con, $prefCourseName);

                    // Elective not fully allocated, allocate it to current student
                    $sqlAllocateElective = mysqli_query($con, "INSERT INTO courses_allocated (courseName, student_reg_no, stream_name, course_type) 
                                                                VALUES ('$courseName', '$studentRegNo', '$streamName', 'Elective')");

                    // Check for errors
                    if (!$sqlAllocateElective) {
                        // Query execution failed, display error and continue to next preference
                        echo "Failed to allocate elective: " . mysqli_error($con);
                        continue;
                    }

                    // Elective successfully allocated, add to selected electives array
                    array_push($selectedElectives, $prefCourseName);
                }
            }
        }

        // Update enrolment status for the student if all electives allocated
        if (count($selectedElectives) == $totalElectivesAllowed) {
            $sqlUpdateStatus = mysqli_query($con, "UPDATE students SET enrolment_status_elective = 1 WHERE studentRegno = '$studentRegNo'");

            // Check for errors
            if (!$sqlUpdateStatus) {
                // Query execution failed, display error and continue to next student
                echo "Failed to update enrolment status: " . mysqli_error($con);
                continue;
            }
        }
    }

    // Remove duplicate entries in courses_allocated table
    $sqlDeleteDuplicates = mysqli_query($con, "DELETE FROM courses_allocated WHERE courses_allocated_id NOT IN (SELECT MIN(courses_allocated_id) FROM courses_allocated GROUP BY student_reg_no, courseName)");

    // Check for errors
    if (!$sqlDeleteDuplicates) {
        // Query execution failed, display error
        echo "Failed to remove duplicate entries: " . mysqli_error($con);
    }

    // Output success message
    echo "<script>alert('Electives allocated.')</script>";
    header('Refresh:0; URL=http://localhost/electives/onlinecourse/admin/allocation.php');
    exit; // Exit script after redirection
}



// Update constraints
if (isset($_POST['submitupdateConstraint'])) {
    $streamid = $_POST['stream_idx'];
    $course = $_POST['course_idx'];
    $newval = $_POST['newconstraint'];
    $escapedCourse = mysqli_real_escape_string($con, $course);
    $sql = mysqli_query($con, "UPDATE total_no_of_seats SET `$escapedCourse`='$newval' WHERE stream_id='$streamid'");

    // Reset enrolment status for electives allocation
    $sql1 = mysqli_query($con, "UPDATE students SET enrolment_status_elective = 0 WHERE stream_id = '$streamid'");
    // Remove allocated courses for re-allocation
    $sql2 = mysqli_query($con, "DELETE FROM courses_allocated  WHERE student_reg_no IN (
                                    SELECT studentRegno FROM students WHERE stream_id = '$streamid'
                                )");
    echo "<script>alert('Constraints are updated and students are deallocated.')</script>";
    header('Refresh:0; URL=http://localhost/electives/onlinecourse/admin/allocation.php');
    exit; // Exit script after redirection
}
?>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Student Profile</title>
    <link href="../assets/css/bootstrap.css" rel="stylesheet" />
    <link href="../assets/css/font-awesome.css" rel="stylesheet" />
    <link href="../assets/css/style.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
    <?php include('includes/header.php');?>
    <?php if($_SESSION['alogin']!="") {
        include('includes/menubar.php');
    }
    ?>
    <div class="content-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-head-line">Allocation</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Allocation
                        </div>
                        <div class="panel-body">
                            <form method="post">
                                <div class="form-group">
                                    <label for="stream_name">Select Stream to Allocate Optional Cores</label>
                                    <select class="form-control" name="stream_idx" required="required">
                                        <option value="">Select Stream</option>
                                        <?php 
                                        $sql = mysqli_query($con, "select * from stream");
                                        while($row = mysqli_fetch_array($sql)) {
                                            ?>
                                            <option value="<?php echo htmlentities($row['stream_id']);?>"><?php echo htmlentities($row['stream_name']);?></option>
                                            <?php 
                                        }
                                        ?>
                                    </select>
                                </div>
                                <button type="submit" name="submit" id="submit" class="btn btn-default">Allocate Optional Core</button>
                            </form>
                            <br>
                            <br>
                            <form method="post">
                                <div class="form-group">
                                    <label for="stream_name">Select Stream to Allocate Electives</label>
                                    <select class="form-control" name="stream_idx" required="required">
                                        <option value="">Select Stream</option>
                                        <?php 
                                        $sql = mysqli_query($con, "select * from stream");
                                        while($row = mysqli_fetch_array($sql)) {
                                            ?>
                                            <option value="<?php echo htmlentities($row['stream_id']);?>"><?php echo htmlentities($row['stream_name']);?></option>
                                            <?php 
                                        }
                                        ?>
                                    </select>
                                </div>
                                <button type="submit" name="submitElective" id="submitElective" class="btn btn-default">Allocate Electives</button>
                            </form>
                            <br><br>
                            <form method="post">
                                <div class="form-group">
                                    <label for="stream_name">Select Stream</label>
                                    <select class="form-control" name="stream_idx" id="stream_idx" required="required">
                                        <option value="">Select Stream</option>
                                        <?php
                                        $sql = mysqli_query($con, "select * from stream");
                                        while($row = mysqli_fetch_array($sql)) {
                                            ?>
                                            <option value="<?php echo htmlentities($row['stream_id']);?>"><?php echo htmlentities($row['stream_name']);?></option>
                                            <?php 
                                        }
                                        ?>
                                    </select>
                                </div>
                                <div class="col-md-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            Constraints
                                        </div>
                                        <div class="panel-body">
                                            <div class="table-responsive table-bordered">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>Index</th>
                                                            <th>Course Name</th>
                                                            <th>Allocated</th>
                                                            <th>Constraint</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="courseTable">
                                                        <!-- Table rows will be dynamically populated here -->
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <form method="post">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                Update Constraints
                                            </div>
                                            <div class="panel-body">
                                                <div class="form-group">
                                                    <label for="course_name">Select Course</label>
                                                    <select class="form-control" name="course_idx" id="course_idx">
                                                        <option value="">Select Course</option>
                                                        <?php
                                                        $sql = mysqli_query($con, "SELECT * FROM course");
                                                        while ($row = mysqli_fetch_array($sql)) {
                                                            ?>
                                                            <option value="<?php echo htmlentities($row['courseName']); ?>"><?php echo htmlentities($row['courseName']); ?></option>
                                                            <?php 
                                                        }
                                                        ?>
                                                    </select>
                                                    <br>
                                                    <label for="course_name">Max Value Chosen can be :</label>
                                                    <label id="updatedConstraintLabel"></label>
                                                    <br>  
                                                    <label id="updateIt">Enter Updated Constraint Value </label>
                                                    <input type="number" name="newconstraint" id="newconstraint" min="0" max="100">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- <button type="submit" name="submitElective" id="submitElective" class="btn btn-default">Allocate Electives</button> -->
                                <button type="submit" name="submitupdateConstraint" id="submitupdateConstraint" class="btn btn-default">Update Constraint</button>
                                <br>
                            </form>
                            <br>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <?php include('includes/footer.php');?>
    <script src="../assets/js/jquery-1.11.1.js"></script>
    <script src="../assets/js/bootstrap.js"></script>
    <script>
        $(document).ready(function() {
            var streamDropdown = $('#stream_idx');
            var courseTable = $('#courseTable');

            streamDropdown.on('change', function() {
                var selectedStreamId = $(this).val();
                $.ajax({
                    url: 'fetch_courses.php',
                    method: 'POST',
                    data: { stream_idx: selectedStreamId },
                    success: function(response) {
                        courseTable.html(response);
                    },
                    error: function(xhr, status, error) {
                        console.log(error);
                    }
                });
            });
        });
    </script>
    <script>
        $(document).ready(function() {
            $('#course_idx').change(function() {
                var selectedCourse = $(this).val();
                var selectedStreamId = $('#stream_idx').val();

                $.ajax({
                    url: 'fetch_seat_count.php',
                    type: 'POST',
                    data: { course: selectedCourse, stream_idx: selectedStreamId },
                    success: function(response) {
                        var updatedConstraint = parseInt(response.trim());
                        $('#updatedConstraintLabel').text(updatedConstraint);
                        $('#newconstraint').attr('max', updatedConstraint);
                        console.log(response);
                    },
                    error: function() {
                        $('#updatedConstraintLabel').text('0');
                        $('#newconstraint').attr('max', '0');
                    }
                });
            });
        });
    </script>
</body>
</html>

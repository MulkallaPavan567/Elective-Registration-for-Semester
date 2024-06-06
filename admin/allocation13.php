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

                // Fetch bucket_number from course table
                $result_course = mysqli_query($con, "SELECT bucket_number FROM course WHERE courseName = '$courseName'");
                $courseBucketNumber = "";
                if ($row_course = mysqli_fetch_assoc($result_course)) {
                    $courseBucketNumber = $row_course['bucket_number'];
                } else {
                    // Handle the case where courseName doesn't exist in the course table
                    echo "Error: Course '$courseName' not found.";
                    exit;
                }

                $sqlInsert = "INSERT INTO courses_allocated (courseName, bucket_number, student_reg_no, stream_name, course_type)
                                VALUES ('$courseName', '$courseBucketNumber', '$studentRegNo', '$streamName', 'Optional Core')";


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

    // Fetching all students and their elective preferences, sorted by CGPA
    $sqlStudents = mysqli_query($con, "SELECT e.*, st.stream_name 
                                        FROM elective_preference e 
                                        INNER JOIN stream st ON e.stream_name = st.stream_name
                                        INNER JOIN students s ON e.studentRegno = s.studentRegno
                                        WHERE s.stream_id = '$streamId' AND s.enrolment_status_elective = 0 
                                        ORDER BY s.cgpa DESC");

    // Check for errors
    if (!$sqlStudents) {
        // Query execution failed, display error and stop script execution
        die("Query failed: " . mysqli_error($con));
    }

    // Loop through each student
    while ($rowStudent = mysqli_fetch_assoc($sqlStudents)) {
        // Reset total allocated electives for this student
        $allocatedElectives = 0;

        // Loop through each elective preference for this student
        for ($i = 1; $i <= $totalElectivesAllowed; $i++) {
            // Fetching the elective preference of the student for this iteration
            $electivePref = $rowStudent['E' . $i];

            // Check if the preference is not NULL
            if (!is_null($electivePref)) {
                do {
                    // Fetch available seats for this elective
                    $sqlAvailableSeats = mysqli_query($con, "SELECT * FROM course WHERE courseName = '$electivePref'");
                    if (!$sqlAvailableSeats) {
                        die("Query failed: " . mysqli_error($con));
                    }
                    $rowSeats = mysqli_fetch_assoc($sqlAvailableSeats);
                    $seats = 0;

                    // Set the stream name
                    $streamName = $rowStudent['stream_name'];

                    // Calculate total available seats based on the stream
                    switch ($streamName) {
                        case 'MCA':
                            $seats += $rowSeats['seats_for_MCA'];
                            break;
                        case 'MTECH_AI':
                            $seats += $rowSeats['seats_for_MTECH_AI'];
                            break;
                        case 'MTECH_CS':
                            $seats += $rowSeats['seats_for_MTECH_CS'];
                            break;
                        case 'MTECH_IT':
                            $seats += $rowSeats['seats_for_MTECH_IT'];
                            break;
                        case 'IMTECH_3_4':
                            $seats += $rowSeats['seats_for_IMTECH_3_4'];
                            break;
                        case 'IMTECH_5_6':
                            $seats += $rowSeats['seats_for_IMTECH_5_6'];
                            break;
                        case 'IMTECH_7_8':
                            $seats += $rowSeats['seats_for_IMTECH_7_8'];
                            break;
                        default:
                            // Handle unexpected stream names
                            break;
                    }

                    if ($seats <= 0) {
                        // Move to the next preference
                        $i++;
                        $electivePref = $rowStudent['E' . $i];
                    }
                } while ($electivePref && $seats <= 0);

                // Check if there are available seats
                if ($seats > 0) {
                    // Allocate elective to the student
                    $studentRegNo = mysqli_real_escape_string($con, $rowStudent['studentRegno']);
                    $streamName = mysqli_real_escape_string($con, $rowStudent['stream_name']);

                    // Insert data into courses_allocated table
                    $sqlAllocateElective = mysqli_query($con, "INSERT INTO courses_allocated (courseName, student_reg_no, stream_name, course_type) 
                                                                VALUES ('$electivePref', '$studentRegNo', '$streamName', 'Elective')");
                    // Check for errors
                    if (!$sqlAllocateElective) {
                        // Query execution failed, display error and move to next student
                        echo "Failed to allocate elective: " . mysqli_error($con);
                        break;
                    }

                    // Decrement available seats for the course based on the stream
                    switch ($streamName) {
                        case 'MCA':
                            mysqli_query($con, "UPDATE course SET seats_for_MCA = seats_for_MCA - 1 WHERE courseName = '$electivePref'");
                            break;
                        case 'MTECH_AI':
                            mysqli_query($con, "UPDATE course SET seats_for_MTECH_AI = seats_for_MTECH_AI - 1 WHERE courseName = '$electivePref'");
                            break;
                        case 'MTECH_CS':
                            mysqli_query($con, "UPDATE course SET seats_for_MTECH_CS = seats_for_MTECH_CS - 1 WHERE courseName = '$electivePref'");
                            break;
                        case 'MTECH_IT':
                            mysqli_query($con, "UPDATE course SET seats_for_MTECH_IT = seats_for_MTECH_IT - 1 WHERE courseName = '$electivePref'");
                            break;
                        case 'IMTECH_3_4':
                            mysqli_query($con, "UPDATE course SET seats_for_IMTECH_3_4 = seats_for_IMTECH_3_4 - 1 WHERE courseName = '$electivePref'");
                            break;
                        case 'IMTECH_5_6':
                            mysqli_query($con, "UPDATE course SET seats_for_IMTECH_5_6 = seats_for_IMTECH_5_6 - 1 WHERE courseName = '$electivePref'");
                            break;
                        case 'IMTECH_7_8':
                            mysqli_query($con, "UPDATE course SET seats_for_IMTECH_7_8 = seats_for_IMTECH_7_8 - 1 WHERE courseName = '$electivePref'");
                            break;
                        default:
                            // Handle unexpected stream names
                            break;
                    }

                    // Increment total allocated electives for this student
                    $allocatedElectives++;

                    // Check if the student has received the required number of electives
                    if ($allocatedElectives >= $totalElectivesAllowed) {
                        // Update enrolment status for this student
                        mysqli_query($con, "UPDATE students SET enrolment_status_elective = 1 WHERE studentRegno = '{$rowStudent['studentRegno']}'");
                        // Move to the next student
                        break;
                    }
                }
            }
        }
    }

    // Output success message
    echo "<script>alert('Electives allocated.')</script>";
    header('Refresh:0; URL=http://localhost/electives/onlinecourse/admin/allocation.php');
    exit; // Exit script after redirection
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
                                                            <th>Allocated Seats</th>
                                                            <th>Available Seats</th>
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

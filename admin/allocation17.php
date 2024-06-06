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

    // Loop through each elective preference
    for ($i = 1; $i <= $totalElectivesAllowed; $i++) {
        // Loop through each student to allocate electives for this preference
        while ($rowStudent = mysqli_fetch_assoc($sqlStudents)) {
            // Initialize variable to track if elective is allocated for the current student
            $electiveAllocated = false;

            // Fetching the elective preferences of the student for this iteration
            for ($j = 1; $j <= 19; $j++) {
                if (!is_null($rowStudent['E' . $j])) {
                    $electivePref = $rowStudent['E' . $j];

                    // Fetch available seats for this elective
                    $sqlAvailableSeats = mysqli_query($con, "SELECT * FROM course WHERE courseName = '$electivePref'");
                    if (!$sqlAvailableSeats) {
                        die("Query failed: " . mysqli_error($con));
                    }
                    $rowSeats = mysqli_fetch_assoc($sqlAvailableSeats);

                    // Calculate total available seats based on the student's stream
                    $streamName = $rowStudent['stream_name'];
                    $seats = $rowSeats['seats_for_' . $streamName];

                    // Check if there are available seats and the elective doesn't belong to an already allocated bucket number
                    if ($seats > 0 && !isBucketNumberAllocated($con, $rowStudent['studentRegno'], $electivePref)) {
                        // Allocate elective to the student
                        $studentRegNo = mysqli_real_escape_string($con, $rowStudent['studentRegno']);
                        $streamName = mysqli_real_escape_string($con, $rowStudent['stream_name']);

                        // Fetch bucket_number from course table
                        $result_course = mysqli_query($con, "SELECT bucket_number FROM course WHERE courseName = '$electivePref'");
                        $courseBucketNumber = "";
                        if ($row_course = mysqli_fetch_assoc($result_course)) {
                            $courseBucketNumber = $row_course['bucket_number'];
                        } else {
                            // Handle the case where courseName doesn't exist in the course table
                            echo "Error: Course '$electivePref' not found.";
                            exit;
                        }

                        // Insert data into courses_allocated table
                        $sqlAllocateElective = mysqli_query($con, "INSERT INTO courses_allocated (courseName, bucket_number, student_reg_no, stream_name, course_type) 
                                                                VALUES ('$electivePref', '$courseBucketNumber', '$studentRegNo', '$streamName', 'Elective')");
                        // Check for errors
                        if (!$sqlAllocateElective) {
                            // Query execution failed, display error and continue to next student
                            echo "Failed to allocate elective: " . mysqli_error($con);
                            continue;
                        }

                        // Decrement available seats for the course
                        mysqli_query($con, "UPDATE course SET seats_for_$streamName = seats_for_$streamName - 1 WHERE courseName = '$electivePref'");

                        // Mark elective as allocated for the student
                        $electiveAllocated = true;

                        break; // Exit the loop once elective is allocated
                    }
                }
            }

            // Check if elective is allocated for the current student
            if (!$electiveAllocated) {
                // No available elective for the student, move to the next student
                continue;
            }
        }

        // Reset the result pointer to start from the first row again for the next elective preference
        mysqli_data_seek($sqlStudents, 0);
    }

    // Update enrolment status for all students
    mysqli_query($con, "UPDATE students SET enrolment_status_elective = 1 WHERE stream_id = '$streamId'");

    // Output success message
    echo "<script>alert('Electives allocated.')</script>";
    header('Refresh:0; URL=http://localhost/electives/onlinecourse/admin/allocation.php');
    exit; // Exit script after redirection
}

// Function to check if the bucket number is already allocated to the student
function isBucketNumberAllocated($con, $studentRegNo, $electivePref)
{
    $query = "SELECT * FROM courses_allocated WHERE student_reg_no = '$studentRegNo' AND bucket_number = 
              (SELECT bucket_number FROM course WHERE courseName = '$electivePref')";
    $result = mysqli_query($con, $query);
    return mysqli_num_rows($result) > 0;
}

// Update constraints
if (isset($_POST['submitupdateConstraint'])) {
    $streamid = $_POST['stream_idx'];
    // $course = $_POST['course_idx'];
    // $newval = $_POST['newconstraint'];
    //$escapedCourse = mysqli_real_escape_string($con, $course);
    //$courseName = mysqli_real_escape_string($con, $courseName);
    // Fetch the course name from the query result
    $queryResult = mysqli_query($con, "SELECT courseName FROM courses_allocated");
    $row = mysqli_fetch_assoc($queryResult);
    $courseName = $row['courseName'];

    //Reset the count to original

    //Updating the new constraint values
    //$sql = mysqli_query($con, "UPDATE seats_for_MCA, seats_for_MTECH_AI, seats_for_MTECH_CS, seats_for_MTECH_IT, seats_for_IMTECH_3_4, seats_for_IMTECH_5_6, seats_for_IMTECH_7_8, SET `$escapedCourse`='$newval' WHERE stream_id='$streamid'");

    // Reset enrolment status for electives allocation
    $sql1 = mysqli_query($con, "UPDATE students SET enrolment_status_elective = 0 WHERE stream_id = '$streamid'");

    // Increment count in the course table
    // $sql2 = mysqli_query($con, "UPDATE course 
    // SET 
    //     seats_for_MCA = seats_for_MCA + (SELECT COUNT(*) FROM courses_allocated WHERE courseName = '$courseName' AND stream_name = (SELECT stream_name FROM stream WHERE stream_id = '$streamid') AND course_type = 'Elective'),
    //     seats_for_MTECH_AI = seats_for_MTECH_AI + (SELECT COUNT(*) FROM courses_allocated WHERE courseName = '$courseName' AND stream_name = (SELECT stream_name FROM stream WHERE stream_id = '$streamid') AND course_type = 'Elective'),
    //     seats_for_MTECH_CS = seats_for_MTECH_CS + (SELECT COUNT(*) FROM courses_allocated WHERE courseName = '$courseName' AND stream_name = (SELECT stream_name FROM stream WHERE stream_id = '$streamid') AND course_type = 'Elective'),
    //     seats_for_MTECH_IT = seats_for_MTECH_IT + (SELECT COUNT(*) FROM courses_allocated WHERE courseName = '$courseName' AND stream_name = (SELECT stream_name FROM stream WHERE stream_id = '$streamid') AND course_type = 'Elective'),
    //     seats_for_IMTECH_3_4 = seats_for_IMTECH_3_4 + (SELECT COUNT(*) FROM courses_allocated WHERE courseName = '$courseName' AND stream_name = (SELECT stream_name FROM stream WHERE stream_id = '$streamid') AND course_type = 'Elective'),
    //     seats_for_IMTECH_5_6 = seats_for_IMTECH_5_6 + (SELECT COUNT(*) FROM courses_allocated WHERE courseName = '$courseName' AND stream_name = (SELECT stream_name FROM stream WHERE stream_id = '$streamid') AND course_type = 'Elective'),
    //     seats_for_IMTECH_7_8 = seats_for_IMTECH_7_8 + (SELECT COUNT(*) FROM courses_allocated WHERE courseName = '$courseName' AND stream_name = (SELECT stream_name FROM stream WHERE stream_id = '$streamid') AND course_type = 'Elective')
    // WHERE courseName = '$courseName'");

    // Replace the values in the course table with those from course_backup table based on the selected stream
    // Get the distinct course names for which updates are needed
    // $distinctCoursesQuery = mysqli_query($con, "SELECT DISTINCT courseName FROM course");

    // while ($row = mysqli_fetch_assoc($distinctCoursesQuery)) {
    //     $courseName = $row['courseName'];

    //     // Update the course table with corresponding values from course_backup table based on the selected stream
    //     $sql2 = mysqli_query($con, "UPDATE course AS c
    //     JOIN (
    //         SELECT 
    //             courseName,
    //             seats_for_MCA,
    //             seats_for_MTECH_AI,
    //             seats_for_MTECH_CS,
    //             seats_for_MTECH_IT,
    //             seats_for_IMTECH_3_4,
    //             seats_for_IMTECH_5_6,
    //             seats_for_IMTECH_7_8
    //         FROM course_backup
    //     ) AS cb ON c.courseName = cb.courseName
    //     SET 
    //         c.seats_for_MCA = cb.seats_for_MCA,
    //         c.seats_for_MTECH_AI = cb.seats_for_MTECH_AI,
    //         c.seats_for_MTECH_CS = cb.seats_for_MTECH_CS,
    //         c.seats_for_MTECH_IT = cb.seats_for_MTECH_IT,
    //         c.seats_for_IMTECH_3_4 = cb.seats_for_IMTECH_3_4,
    //         c.seats_for_IMTECH_5_6 = cb.seats_for_IMTECH_5_6,
    //         c.seats_for_IMTECH_7_8 = cb.seats_for_IMTECH_7_8
    //     WHERE c.courseName = '$courseName'");
    // }
    // Get the distinct course names for which updates are needed
    $distinctCoursesQuery = mysqli_query($con, "SELECT DISTINCT courseName FROM course");

    while ($row = mysqli_fetch_assoc($distinctCoursesQuery)) {
        $courseName = $row['courseName'];

        // Update the course table with corresponding values from course_backup table based on the selected stream
        $sql2 = mysqli_query($con, "UPDATE course AS c
        JOIN (
            SELECT 
                courseName,
                seats_for_MCA,
                seats_for_MTECH_AI,
                seats_for_MTECH_CS,
                seats_for_MTECH_IT,
                seats_for_IMTECH_3_4,
                seats_for_IMTECH_5_6,
                seats_for_IMTECH_7_8
            FROM course_backup
        ) AS cb ON c.courseName = cb.courseName
        SET 
            c.seats_for_MCA = IF('$streamid' = '1', cb.seats_for_MCA, c.seats_for_MCA),
            c.seats_for_MTECH_AI = IF('$streamid' = '2', cb.seats_for_MTECH_AI, c.seats_for_MTECH_AI),
            c.seats_for_MTECH_CS = IF('$streamid' = '3', cb.seats_for_MTECH_CS, c.seats_for_MTECH_CS),
            c.seats_for_MTECH_IT = IF('$streamid' = '4', cb.seats_for_MTECH_IT, c.seats_for_MTECH_IT),
            c.seats_for_IMTECH_3_4 = IF('$streamid' = '5', cb.seats_for_IMTECH_3_4, c.seats_for_IMTECH_3_4),
            c.seats_for_IMTECH_5_6 = IF('$streamid' = '6', cb.seats_for_IMTECH_5_6, c.seats_for_IMTECH_5_6),
            c.seats_for_IMTECH_7_8 = IF('$streamid' = '7', cb.seats_for_IMTECH_7_8, c.seats_for_IMTECH_7_8)
        WHERE c.courseName = '$courseName'");
    }

    // Remove allocated courses for re-allocation
    $sql3 = mysqli_query($con, "DELETE FROM courses_allocated  WHERE student_reg_no IN (
                                    SELECT studentRegno FROM students WHERE stream_id = '$streamid' AND course_type = 'Elective'
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
    <?php include('includes/header.php'); ?>
    <?php if ($_SESSION['alogin'] != "") {
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
                                        while ($row = mysqli_fetch_array($sql)) {
                                        ?>
                                            <option value="<?php echo htmlentities($row['stream_id']); ?>"><?php echo htmlentities($row['stream_name']); ?></option>
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
                                        while ($row = mysqli_fetch_array($sql)) {
                                        ?>
                                            <option value="<?php echo htmlentities($row['stream_id']); ?>"><?php echo htmlentities($row['stream_name']); ?></option>
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
                                        while ($row = mysqli_fetch_array($sql)) {
                                        ?>
                                            <option value="<?php echo htmlentities($row['stream_id']); ?>"><?php echo htmlentities($row['stream_name']); ?></option>
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
                                                            <th>Allocated_Seats</th>
                                                            <th>Available_Seats</th>
                                                            <!-- <th>Edit seat_count</th> -->
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
                                                Reset Constraints
                                            </div>
                                            <div class="panel-body">
                                                <div class="form-group">
                                                    <div class="form-group">
                                                        <label for="stream_name">Select Stream</label>
                                                        <select class="form-control" name="stream_idx" id="stream_idx" required="required">
                                                            <option value="">Select Stream</option>
                                                            <?php
                                                            $sql = mysqli_query($con, "select * from stream");
                                                            while ($row = mysqli_fetch_array($sql)) {
                                                            ?>
                                                                <option value="<?php echo htmlentities($row['stream_id']); ?>"><?php echo htmlentities($row['stream_name']); ?></option>
                                                            <?php
                                                            }
                                                            ?>
                                                        </select>
                                                    </div>
                                                    <!-- <label for="course_name">Select Course</label>
                                                    <select class="form-control" name="course_idx" id="course_idx">
                                                        <option value="">Select Course</option>
                                                        <?php
                                                        // $sql = mysqli_query($con, "SELECT * FROM course");
                                                        // while ($row = mysqli_fetch_array($sql)) {
                                                        ?>
                                                            <option value="<?php echo htmlentities($row['courseName']); ?>"><?php echo htmlentities($row['courseName']); ?></option>
                                                        <?php
                                                        //}
                                                        ?>
                                                    </select>
                                                    <br>
                                                    <label for="course_name">Max Value Chosen can be :</label>
                                                    <label id="updatedConstraintLabel"></label>
                                                    <br>
                                                    <label id="updateIt">Enter Updated Constraint Value </label>
                                                    <input type="number" name="newconstraint" id="newconstraint" min="0" max="100"> -->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- <button type="submit" name="submitElective" id="submitElective" class="btn btn-default">Allocate Electives</button> -->
                                <button type="submit" name="submitupdateConstraint" id="submitupdateConstraint" class="btn btn-default">Reset Constraint</button>
                                <br>
                            
                            <br>
                        </div>
                        <!-- edit constraints -->
                        <form method="post">
                            <!-- <div class="form-group">
            <div class="content-wrapper">
                <div class="container">
                    <div class="row"> -->
                            <div class="col-md-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        Update Constraints
                                    </div>
                                    <div class="panel-body">
                                        <div class="table-responsive table-bordered">
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th>Action</th>
                                                        <th>courseName</th>
                                                        <th>seats for MCA </th>
                                                        <th>seats for MTECH AI </th>
                                                        <th>seats for MTECH CS</th>
                                                        <th>seats for MTECH IT</th>
                                                        <th>seats for IMTECH 3-4</th>
                                                        <th>seats for IMTECH 5-6</th>
                                                        <th>seats for IMTECH 7-8</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <?php
                                                    $sql = mysqli_query($con, "SELECT * FROM course");
                                                    while ($row = mysqli_fetch_array($sql)) {
                                                    ?>
                                                        <tr>
                                                            <td>
                                                                <a href="edit-constraints.php?courseName=<?php echo urlencode($row['courseName']); ?>" class="btn btn-primary"><i class="fa fa-edit"></i> Edit</a>
                                                            </td>
                                                            <td><?php echo htmlentities($row['courseName']); ?></td>
                                                            <td><?php echo htmlentities($row['seats_for_MCA']); ?></td>
                                                            <td><?php echo htmlentities($row['seats_for_MTECH_AI']); ?></td>
                                                            <td><?php echo htmlentities($row['seats_for_MTECH_CS']); ?></td>
                                                            <td><?php echo htmlentities($row['seats_for_MTECH_IT']); ?></td>
                                                            <td><?php echo htmlentities($row['seats_for_IMTECH_3_4']); ?></td>
                                                            <td><?php echo htmlentities($row['seats_for_IMTECH_5_6']); ?></td>
                                                            <td><?php echo htmlentities($row['seats_for_IMTECH_7_8']); ?></td>
                                                        </tr>
                                                    <?php
                                                    }
                                                    ?>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- </div>
                </div>
            </div>
        </div> -->
                        </form>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>


    <?php include('includes/footer.php'); ?>
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
                    data: {
                        stream_idx: selectedStreamId
                    },
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
                    data: {
                        course: selectedCourse,
                        stream_idx: selectedStreamId
                    },
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
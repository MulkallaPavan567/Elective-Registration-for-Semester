<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Course Enroll</title>
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <link href="assets/css/style.css" rel="stylesheet" />
    <style>
        /* Style for disabled options */
        option:disabled {
            color: red;
        }
    </style>
</head>

<body>

    <?php 
    session_start();
    include('includes/config.php');
    error_reporting(E_ALL); // Add this line to display all PHP errors
    ini_set('display_errors', 1); // Add this line to display all PHP errors

    // Check if the session variable is set
    if (!isset($_SESSION['login'])) {
        die('Session login not set');
    }

    // Perform the SQL query to fetch student data
    $query = "SELECT * FROM students WHERE studentRegno='" . $_SESSION['login'] . "'";
    $sql = mysqli_query($con, $query);

    // Check if the query executed successfully
    if (!$sql) {
        die('Error executing SQL query: ' . mysqli_error($con));
    }

    // Fetch the data from the result set
    $row = mysqli_fetch_array($sql);

    // Check if any data was fetched
    if (!$row) {
        die('No data found for studentRegno: ' . $_SESSION['login']);
    }

    // Fetch stream data
    $query_stream = "SELECT * FROM stream WHERE stream_id='" . $row['stream_id'] . "'";
    $sql1 = mysqli_query($con, $query_stream);

    // Check if the query executed successfully
    if (!$sql1) {
        die('Error executing SQL query: ' . mysqli_error($con));
    }

    // Fetch the data from the result set
    $row1 = mysqli_fetch_array($sql1);

    // Fetching the number of optional cores for the current stream from the database
    $query_optional_cores = "SELECT optional_cores_count FROM set_oc_electives WHERE stream_name='" . $row1['stream_name'] . "'";
    $optional_core_count_query = mysqli_query($con, $query_optional_cores);

    // Check if the query executed successfully
    if (!$optional_core_count_query) {
        die('Error executing SQL query: ' . mysqli_error($con));
    }

    $optional_core_count_row = mysqli_fetch_array($optional_core_count_query);
    $optional_core_count = $optional_core_count_row['optional_cores_count'];

    // Redirect to elective-preference.php if the optional_core_count is less than or equal to 0
    if ($optional_core_count <= 0) {
        header('location:elective-preference.php');
        exit();
    }

    // Fetch course details with bucket_number from the database
    $query_courses = "SELECT courseName, bucket_number FROM course";
    $courses_result = mysqli_query($con, $query_courses);

    // Fetch all courses with their bucket numbers
    $course_buckets = [];
    while ($course_row = mysqli_fetch_assoc($courses_result)) {
        $course_buckets[$course_row['courseName']] = $course_row['bucket_number'];
    }

    //existing PHP code 

    if (isset($_POST['submit1'])) {
        header('location:elective-preference.php');
        exit();
    }

    if (isset($_POST['submit'])) {
        $selected_val = $_POST['optional_cores'];
        $sql = mysqli_query($con, "select * from students where studentRegno='" . $_SESSION['login'] . "'");
        $row = mysqli_fetch_array($sql);

        // Update the optional core choices in the database
        $optional_core_choice_1 = isset($selected_val[0]) ? $selected_val[0] : "NULL";
        $optional_core_choice_2 = isset($selected_val[1]) ? $selected_val[1] : "NULL";
        $optional_core_choice_3 = isset($selected_val[2]) ? $selected_val[2] : "NULL";
        $optional_core_choice_4 = isset($selected_val[3]) ? $selected_val[3] : "NULL";
        $optional_core_choice_5 = isset($selected_val[4]) ? $selected_val[4] : "NULL";

        $sql3 = "UPDATE students SET optional_core_choice_1 = '" . $optional_core_choice_1 . "', optional_core_choice_2 ='" . $optional_core_choice_2 . "', optional_core_choice_3='" . $optional_core_choice_3 . "', optional_core_choice_4 ='" . $optional_core_choice_4 . "', optional_core_choice_5='" . $optional_core_choice_5 . "'
        WHERE studentRegno='" . $_SESSION['login'] . "'";
        mysqli_query($con, $sql3);
        echo '<script>alert("Optional Core Uploaded Successfully Proceed for Elective Preference Upload");</script>';
    }
    ?>

    <!-- HTML content -->
    <?php include('includes/header.php'); ?>
    <?php if ($_SESSION['login'] != "") {
        include('includes/menubar.php');
    } ?>

    <div class="content-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-head-line">Course Enroll </h1>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Course Enroll
                        </div>
                        <font color="green" align="center"><?php echo htmlentities($_SESSION['msg']); ?><?php echo htmlentities($_SESSION['msg'] = ""); ?></font>
                        <?php $sql = mysqli_query($con, "select * from students where studentRegno='" . $_SESSION['login'] . "'");
                        $cnt = 1;
                        while ($row = mysqli_fetch_array($sql)) { ?>

                            <div class="panel-body">
                                <form name="dept" method="post" enctype="multipart/form-data">
                                    <div class="form-group">
                                        <label for="studentname">Student Name </label>
                                        <input type="text" class="form-control" id="studentname" name="studentname" value="<?php echo htmlentities($row['studentName']); ?>" readonly />
                                    </div>

                                    <div class="form-group">
                                        <label for="studentRegno">Student Reg No </label>
                                        <input type="text" class="form-control" id="studentRegno" name="studentRegno" value="<?php echo htmlentities($row['studentRegno']); ?>" placeholder="Student Reg no" readonly />
                                    </div>

                                    <div class="form-group">
                                        <label for="Department">Stream </label>
                                        <?php
                                        $sql1 = mysqli_query($con, "select * from stream where stream_id='" . $row['stream_id'] . "'");
                                        $row1 = mysqli_fetch_array($sql1);
                                        //  echo var_dump($row1); 
                                        ?>
                                        <input type="text" class="form-control" id="streamName" name="streamName" readonly value="<?php echo htmlentities($row1['stream_name']); ?>" required />
                                    </div>

                                    <div class="form-group">
                                        <label for="Course">Course </label>
                                        <?php
                                        $sql2 = mysqli_query($con, "select * from eligible_optional_core where stream_id='" . $row['stream_id'] . "'");
                                        $row2 = mysqli_fetch_all($sql2, MYSQLI_ASSOC);
                                        for ($i = 0; $i < $optional_core_count; $i++) {
                                            $selected_values = isset($_POST['optional_cores'][$i]) ? $_POST['optional_cores'][$i] : ''; // get the previously selected value
                                        ?>
                                            <select class="form-control" name="optional_cores[]" id="optional_cores_<?php echo $i; ?>" required="required">
                                                <option value="">Select Optional Core</option>
                                                <?php foreach ($row2 as $rows2) {
                                                    $courseName = htmlentities($rows2['courseName']);
                                                    $bucket_number = $course_buckets[$courseName];
                                                ?>
                                                    <option value="<?php echo $courseName; ?>" <?php if ($selected_values == $courseName) {
                                                                                                    echo 'disabled';
                                                                                                } ?> data-bucket="<?php echo $bucket_number; ?>"><?php echo $courseName; ?></option>
                                                <?php } ?>
                                            </select>
                                            <br>
                                        <?php } ?>
                                        <span id="course-availability-status1" style="font-size:12px;"></span>
                                    </div>

                                    <button type="submit" name="submit" id="submit" class="btn btn-default">Submit Optional Cores</button>
                                </form>
                                <br>

                                <form method='post'>
                                    <div>
                                        <button type="submit" name="submit1" id="submit1" class="btn btn-default" <?php if ($optional_core_count <= 0) {
                                                                                                                            echo 'disabled';
                                                                                                                        } ?>>Proceed for Elective Preference</button>
                                    </div>
                                </form>

                            </div>
                        <?php } ?>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <?php include('includes/footer.php'); ?>
    <script src="assets/js/jquery-1.11.1.js"></script>
    <script src="assets/js/bootstrap.js"></script>
    <script>
        // Function to disable options based on bucket_number
        function disableOptions(selectElement, bucketNumber) {
            var options = selectElement.querySelectorAll('option');
            options.forEach(function(option) {
                // Get the bucket_number of the option
                var optionBucket = option.getAttribute('data-bucket');
                // Check if option's bucket_number matches the selected bucket_number
                if (optionBucket === bucketNumber) {
                    // Disable the option
                    option.disabled = true;
                }
            });
        }

        // bind onchange event to each select element
        var selectElements = document.querySelectorAll('[name="optional_cores[]"]');
        selectElements.forEach(function(element, index) {
            element.addEventListener('change', function() {
                // get the selected value
                var selectedValue = this.value;
                // find the selected option
                var selectedOption = this.querySelector('option[value="' + selectedValue + '"]');
                // get the bucket_number from the selected option
                var bucketNumber = selectedOption.getAttribute('data-bucket');
                // disable options in subsequent select elements based on bucket_number
                for (var i = index + 1; i < selectElements.length; i++) {
                    // Reset options first
                    selectElements[i].querySelectorAll('option').forEach(function(option) {
                        option.disabled = false;
                    });
                    // Then disable options with the same bucket_number
                    disableOptions(selectElements[i], bucketNumber);
                }
            });
        });
    </script>

</body>

</html>

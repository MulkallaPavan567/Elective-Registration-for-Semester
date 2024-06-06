<?php
session_start();
include('includes/config.php');
error_reporting(E_ALL);
ini_set('display_errors', 1);

if (strlen($_SESSION['alogin']) == 0) {
    header('location:index.php');
} else {
    if (isset($_POST['submit'])) {
        $streamId = $_POST['stream_idx'];

        // Check if the column enrolment_status exists in the students table
        $result = mysqli_query($con, "SHOW COLUMNS FROM students WHERE Field = 'enrolment_status'");
        if (!$result || mysqli_num_rows($result) == 0) {
            echo "Column 'enrolment_status' does not exist in the students table. Please check your database schema.";
            exit;
        }

        $sql = mysqli_query($con, "SELECT studentRegno, course_name, optional_core_choice_1, optional_core_choice_2, optional_core_choice_3, optional_core_choice_4, optional_core_choice_5
                                    FROM students
                                    WHERE stream_id = '$streamId' AND enrolment_status = 0
                                    ORDER BY cgpa DESC");
        if (!$sql) {
            echo "Error in SQL query: " . mysqli_error($con);
            exit;
        }

        while ($row = mysqli_fetch_array($sql)) {
            $choices = array($row['optional_core_choice_1'], $row['optional_core_choice_2'], $row['optional_core_choice_3'], $row['optional_core_choice_4'], $row['optional_core_choice_5']);

            foreach ($choices as $choice) {
                if ($choice != NULL && $choice != "NULL") {
                    $courseCode = mysqli_real_escape_string($con, $choice);
                    $studentRegNo = mysqli_real_escape_string($con, $row['studentRegno']);
                    $course_name = mysqli_real_escape_string($con, $row['course_name']);

                    $sqlInsert = "INSERT INTO courses_allocated (course_code, student_reg_no,course_name)
                                    VALUES ('$courseCode', '$studentRegNo', '$course_name')";

                    if (!mysqli_query($con, $sqlInsert)) {
                        echo "Error in allocating course: " . mysqli_error($con);
                        exit; // Exit loop if error occurs
                    }
                }
            }
            // Update enrolment status
            $sqlUpdate = "UPDATE students SET enrolment_status = 1 WHERE studentRegno = '{$row['studentRegno']}'";
            if (!mysqli_query($con, $sqlUpdate)) {
                echo "Error in updating enrolment status: " . mysqli_error($con);
                exit; // Exit loop if error occurs
            }
            // echo "Enrolment status updated for student with Reg No: " . $row['studentRegno'] . "<br>";
        }
        // Remove duplicate values
        $sqlDeleteDuplicate = "DELETE FROM courses_allocated 
                               WHERE courses_allocated_id NOT IN (
                                    SELECT MIN(courses_allocated_id)
                                    FROM courses_allocated
                                    GROUP BY student_reg_no, course_code
                               )";
        if (!mysqli_query($con, $sqlDeleteDuplicate)) {
            echo "Error in removing duplicate values: " . mysqli_error($con);
            exit;
        }
        // echo 'Optional cores allocated.';
        echo "<script>alert('Optional cores allocated.')</script>";
        echo '<META HTTP-EQUIV="Refresh" CONTENT="0; URL=http://localhost/electives/onlinecourse/admin/allocation.php">';
    }
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
    <!-- LOGO HEADER END-->
    <?php if ($_SESSION['alogin'] != "") {
        include('includes/menubar.php');
    } ?>
    <!-- MENU SECTION END-->
    <div class="content-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-head-line">Allocation </h1>
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
                                    <label for="stream_name">Select Stream</label>
                                    <select class="form-control" name="stream_idx" required="required">
                                        <option value="">Select Stream</option>
                                        <?php
                                        $sql = mysqli_query($con, "SELECT * FROM set_oc_electives");
                                        while ($row = mysqli_fetch_array($sql)) {
                                        ?>
                                            <option value="<?php echo htmlentities($row['stream_id']); ?>"><?php echo htmlentities($row['stream_name']); ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                                <button type="submit" name="submit" class="btn btn-default">Allocate Optional Core</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>

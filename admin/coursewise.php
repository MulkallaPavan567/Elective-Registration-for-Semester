<?php
session_start();
include('includes/config.php');
error_reporting(0);
if(strlen($_SESSION['alogin'])==0) {   
    header('location:index.php');
} else {
    if(isset($_POST['submit'])) {
        $courseName = $_POST['courseName'];
    
        // Fetch student registration numbers and names from database
        $sql1 = mysqli_prepare($con, "SELECT student_reg_no FROM courses_allocated WHERE courseName=?");
        mysqli_stmt_bind_param($sql1, "s", $courseName);
        mysqli_stmt_execute($sql1);
        $result1 = mysqli_stmt_get_result($sql1);
    
        $students = array();
    
        while ($row = mysqli_fetch_array($result1)) {
            $sql2 = mysqli_prepare($con, "SELECT studentName FROM students WHERE studentRegno=?");
            mysqli_stmt_bind_param($sql2, "s", $row['student_reg_no']);
            mysqli_stmt_execute($sql2);
            $result2 = mysqli_stmt_get_result($sql2);
            $row2 = mysqli_fetch_array($result2);
    
            $students[] = array('reg_no' => $row['student_reg_no'], 'name' => $row2['studentName']);
        }
    
        // Generate CSV file
        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename='.$courseName.'.csv');
    
        $output = fopen('php://output', 'w');
        fputcsv($output, array('Student Reg No', 'Name'));
    
        foreach ($students as $student) {
            fputcsv($output, $student);
        }
    
        fclose($output);
        exit();
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
                <h1 class="page-head-line">Student Registration</h1>
            </div>
        </div>
        <div class="row" >
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Student Registration
                    </div>
                    <font color="green"><?php echo htmlentities($_SESSION['msg']);?><?php echo htmlentities($_SESSION['msg']="");?></font>
                    <div class="panel-body">
                        <form method="post">
                            <div class="form-group">
                                <label for="courseName">Select Course</label>
                                <select class="form-control" name="courseName" required="required">
                                    <option value="">Select Course Name</option>
                                    <?php 
                                        $sql=mysqli_query($con,"select * from course");
                                        while($row=mysqli_fetch_array($sql)) {
                                    ?>
                                    <option value="<?php echo htmlentities($row['courseName']);?>"><?php echo htmlentities($row['courseName']);?></option>
                                    <?php } ?>
                                </select> 
                            </div> 
                            <button type="submit" name="submit" id="submit" class="btn btn-default">Generate Reports</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<?php include('includes/footer.php');?>
<script src="../assets/js/jquery-1.11.1.js"></script>
<script src="../assets/js/bootstrap.js"></script>
</body>
</html>

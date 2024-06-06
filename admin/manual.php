<?php
session_start();
include('includes/config.php');
if(strlen($_SESSION['alogin'])==0)
{   
    header('location:index.php');
}
else{
    if(isset($_POST['submit'])) {
        $studentname=$_POST['studentname'];
        $studentRegno=$_POST['studentRegno'];
        $course_name = $_POST['course_name'];
        $password=$_POST['password'];
        // $pincode = rand(100000,999999);
        
        // Fetching stream_id based on the selected course_name
        $stmt = $con->prepare("SELECT stream_id FROM stream WHERE stream_name = ?");
        $stmt->bind_param("s", $course_name);
        $stmt->execute();
        $stmt->bind_result($stream_id);
        $stmt->fetch();
        $stmt->close();
        
        // Inserting student data into the database
        $stmt = $con->prepare("INSERT INTO students (studentName, studentRegno, password, pincode, stream_id, course_name) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("ssssss", $studentname, $studentRegno, $password, $pincode, $stream_id, $course_name);
        $ret = $stmt->execute();
        $stmt->close();
        
        if($ret) {
            echo '<script>alert("Student Registered Successfully.")</script>';
            echo '<script>window.location.href=manage-students.php</script>';
        } else {
            echo '<script>alert("Something went wrong. Please try again.")</script>';
            echo '<script>window.location.href=manage-students.php</script>';
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
    <title>Admin | Student Registration</title>
    <link href="../assets/css/bootstrap.css" rel="stylesheet" />
    <link href="../assets/css/font-awesome.css" rel="stylesheet" />
    <link href="../assets/css/style.css" rel="stylesheet" />
    
</head>

<body>
    <?php include('includes/header.php');?>
    <?php if($_SESSION['alogin']!="") {
        include('includes/menubar.php');
    } ?>
    <div class="content-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="page-head-line">Student Registration</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">Student Registration</div>
                        <div class="panel-body">
                            <form name="dept" method="post">
                                <div class="form-group">
                                    <label for="studentname">Student Name</label>
                                    <input type="text" class="form-control" id="studentname" name="studentname" placeholder="Student Name" required />
                                </div>
                                <div class="form-group">
                                    <label for="studentRegno">Student Reg No</label>
                                    <input type="text" class="form-control" id="studentRegno" name="studentRegno" onBlur="userAvailability()" placeholder="Student Reg no" required />
                                    <span id="user-availability-status1" style="font-size:12px;"></span>
                                </div>
                                <div class="form-group">
                                    <label for="course_name">Course Name</label>
                                    <select class="form-control" id="course_name" name="course_name" required>
                                        <option value="">Select Course</option>
                                        <option value="MCA">MCA</option>
                                        <option value="MTECH_AI">MTECH_AI</option>
                                        <option value="MTECH_CS">MTECH_CS</option>
                                        <option value="MTECH_IT">MTECH_IT</option>
                                        <option value="IMTECH_3_4">IMTECH_3_4</option>
                                        <option value="IMTECH_5_6">IMTECH_5_6</option>
                                        <option value="IMTECH_7_8">IMTECH_7_8</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required />
                                </div>   
                                <button type="submit" name="submit" id="submit" class="btn btn-default">Submit</button>
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
    <script>
    function userAvailability() {
        $("#loaderIcon").show();
        jQuery.ajax({
            url: "check_availability.php",
            data:'regno='+$("#studentRegno").val(),
            type: "POST",
            success:function(data){
                $("#user-availability-status1").html(data);
                $("#loaderIcon").hide();
            },
            error:function (){}
        });
    }
    </script>
    <script>
    $(document).ready(function(){
        $('#course_name').change(function(){
            var courseName = $(this).val();
            $.ajax({
                url: 'get_stream_id.php',
                type: 'post',
                data: {course_name: courseName},
                dataType: 'json',
                success:function(response){
                    $('#stream_id').val(response.stream_id);
                }
            });
        });
    });
    </script>
</body>
</html>
<?php } ?>

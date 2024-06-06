<?php
session_start();
include('includes/config.php');
if(strlen($_SESSION['alogin'])==0)
    {   
header('location:index.php');
}
else{

if(isset($_POST['submit']))
{
$studentname=$_POST['studentname'];
$studentRegno=$_POST['studentRegno'];
$stream_id = $_POST['stream_id'];
$course_name = $_POST['course_name'];
$password=$_POST['password'];
$pincode = rand(100000,999999);

$ret=mysqli_query($con,"insert into students(studentName,studentRegno,password,pincode,stream_id,course_name) values('$studentname','$studentRegno','$password','$pincode','$stream_id','$course_name')");
if($ret)
{
// echo '<script>alert("Student Registered Successfully. Pincode is "+"'.$pincode.'")</script>';
echo '<script>alert("Student Registered Successfully.")</script>';
echo '<script>window.location.href=manage-students.php</script>';
}else{
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
    <style>
      .table-container {
            width: 50%;
        }
        table {
            width: 50%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>

<body>
<?php include('includes/header.php');?>
    <!-- LOGO HEADER END-->
<?php if($_SESSION['alogin']!="")
{
 include('includes/menubar.php');
}
 ?>
    <!-- MENU SECTION END-->
    <div class="content-wrapper">
        <div class="container">
              <div class="row">
                    <div class="col-md-12">
                        <h1 class="page-head-line">Student Registration  </h1>
                    </div>
                </div>
                <div class="row" >
                  <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <div class="panel panel-default">
                        <div class="panel-heading">
                          Student Registration
                        </div>
<font color="green" align="center"><?php echo htmlentities($_SESSION['msg']);?><?php echo htmlentities($_SESSION['msg']="");?></font>


                        <div class="panel-body">

                        
                       <form name="dept" method="post">
   <div class="form-group">
    <label for="studentname">Student Name  </label>
    <input type="text" class="form-control" id="studentname" name="studentname" placeholder="Student Name" required />
  </div>

 <div class="form-group">
    <label for="studentRegno">Student Reg No   </label>
    <input type="text" class="form-control" id="studentRegno" name="studentRegno" onBlur="userAvailability()" placeholder="Student Reg no" required />
     <span id="user-availability-status1" style="font-size:12px;">
  </div>

  <div class="form-group">
    <label for="stream_id">Stream ID   </label>
    <input type="text" class="form-control" id="stream_id" name="stream_id" onBlur="userAvailability()" placeholder="Stream ID" required />
     <span id="user-availability-status1" style="font-size:12px;">
  </div>

  <!-- <div class="form-group">
    <label for="course_name">Course Name  </label>
    <input type="text" class="form-control" id="course_name" name="course_name" onBlur="userAvailability()" placeholder="Student Reg no" required />
     <span id="user-availability-status1" style="font-size:12px;">
  </div> -->
  <div class="form-group">
    <label for="course_name">Course Name</label>
    <select class="form-control" id="course_name" name="course_name" required>
        <option value="">Select Course</option>
        <option value="MCA">MCA</option>
        <option value="MTECH_AI">MTECH_AI</option>
        <option value="MTECH_CS">MTECH_CS</option>
        <option value="MTECH_IT">MTECH_IT</option>
        <option value="IMTECH 3-4">IMTECH 3-4</option>
        <option value="IMTECH 5-6">IMTECH 5-6</option>
        <option value="IMTECH 7-8">IMTECH 7-8</option>
    </select>
  </div>


<div class="form-group">
    <label for="password">Password  </label>
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
    </div>
    <center>
    <div class="table-container">
    <table>
        <thead>
            <tr>
                <th>stream_id</th>
                <th>course_name</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>MCA</td>
            </tr>
            <tr>
                <td>2</td>
                <td>MTECH_AI</td>
            </tr>
            <tr>
                <td>3</td>
                <td>MTECH_CS</td>
            </tr>
            <tr>
                <td>4</td>
                <td>MTECH_IT</td>
            </tr>
            <tr>
                <td>5</td>
                <td>IMTECH 3-4</td>
            </tr>
            <tr>
                <td>6</td>
                <td>IMTECH 5-6</td>
            </tr>
            <tr>
                <td>7</td>
                <td>IMTECH 7-8</td>
            </tr>
        </tbody>
    </table>
</div></center>
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


</body>
</html>
<?php } ?>

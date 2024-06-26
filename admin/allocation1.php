<?php
session_start();
include('includes/config.php');
error_reporting(0);
if(strlen($_SESSION['alogin'])==0)
    {   
header('location:index.php');
}
else{
if(isset($_POST['submit']))
{
    
   
 //this is for fetching optional core choices from student table since we're only storing stream id from this page
    $sql = mysqli_query($con, "SELECT studentRegno, optional_core_choice_1, optional_core_choice_2, optional_core_choice_3,enrolment_status_optional 
    FROM students
    WHERE stream_id = '".$_POST['stream_idx']."' AND (optional_core_choice_1 IS NOT NULL OR optional_core_choice_2 IS NOT NULL OR optional_core_choice_3 IS NOT NULL) AND enrolment_status_optional=0
    ORDER BY cgpa DESC;");
while($row=mysqli_fetch_array($sql)){

//    var_dump($row);

//since we have only 3 optional cores at max we're not using loop
//if the optional core choice values are not null insert them into allocated courses table and allocate optional core to the student
        if($row['optional_core_choice_1']!=="NULL"){
        $sql1="INSERT INTO courses_allocated (student_reg_no, course_code, course_name, course_type)
        SELECT 
            '".$row['studentRegno']."',
            (SELECT course_code FROM course WHERE courseName = '".$row['optional_core_choice_1']."'),
            '".$row['optional_core_choice_1']."',
            'optional_Core'
        WHERE '".$row['optional_core_choice_1']."' IS NOT NULL;
        ";
        mysqli_query($con,$sql1);
    }


        if($row['optional_core_choice_2']!=="NULL"){
            $sql1="INSERT INTO courses_allocated (student_reg_no, course_code, course_name, course_type)
        SELECT 
            '".$row['studentRegno']."',
            (SELECT course_code FROM course WHERE courseName = '".$row['optional_core_choice_2']."'),
            '".$row['optional_core_choice_2']."',
            'optional_Core'
        WHERE '".$row['optional_core_choice_2']."' IS NOT NULL;
        ";
        mysqli_query($con,$sql1);
        }
        

        if($row['optional_core_choice_3']!=="NULL"){
        $sql1="INSERT INTO courses_allocated (student_reg_no, course_code, course_name, course_type)
        SELECT 
            '".$row['studentRegno']."',
            (SELECT course_code FROM course WHERE courseName = '".$row['optional_core_choice_3']."'),
            '".$row['optional_core_choice_3']."',
            'optional_Core'
        WHERE '".$row['optional_core_choice_3']."' IS NOT NULL;
        ";
        mysqli_query($con,$sql1);
        }
//this is for removing duplicate values if the submit button is clicked more than once
        $sql1="DELETE FROM courses_allocated 
       WHERE courses_allocated_id NOT IN (
            SELECT MIN(courses_allocated_id)
            FROM courses_allocated
            GROUP BY student_reg_no, course_code
       )";
       mysqli_query($con,$sql1);
       

// updating the status of that student that is enrolled
       $sql1= "UPDATE students
       SET enrolment_status_optional=1
       WHERE studentRegno='".$row['studentRegno']."'; ";
       mysqli_query($con,$sql1);
}

       echo '<script>alert("Optional cores allocated.")</script>';
      
}

if(isset($_POST['submitElective']))
{

    $sql=mysqli_query($con,"SELECT * FROM students JOIN elective_preference ON students.studentRegno = elective_preference.studentRegno WHERE students.stream_id = '".$_POST['stream_idx']."' AND students.enrolment_status_elective = 0
    ORDER BY students.cgpa DESC;");


$sql0=mysqli_query($con, "select * from total_no_of_seats where stream_id='".$_POST['stream_idx']."'");
$row0=mysqli_fetch_array($sql0);
// var_dump ($row);

while($row=mysqli_fetch_array($sql)){
   
    $sqlseats =mysqli_query($con,"SELECT electives FROM set_oc_electives WHERE stream_id='".$_POST['stream_idx']."';");
    $rowseats = mysqli_fetch_array($sqlseats);
    $tempseats=intval($rowseats['electives']);
    // var_dump ($tempseats);

    $bucket_map = array(); // Initialize empty bucket map
    
    for ($i = 1; $i <= 19; $i++) {
        $col_name = 'E'.$i;
        $temp = $row[$col_name];
        if ($row[$col_name] != "NULL" && $row0[$temp] >= 1) {
            $course_code = mysqli_real_escape_string($con, $row[$col_name]);
    
            $sqlbucket=mysqli_query($con,"select bucket_number from course where courseName='$course_code'");
            $result=mysqli_fetch_array($sqlbucket);
    
            // Check if a course from this bucket has already been selected
            if (!isset($bucket_map[$result['bucket_number']]) && $tempseats>0) {
                // No course from this bucket has been selected yet
                $bucket_map[$result['bucket_number']] = true; // Mark this bucket as selected
                $sql1 = "INSERT INTO courses_allocated (student_reg_no, course_code, course_name, course_type)
                         SELECT 
                             '".$row['studentRegno']."',
                             (SELECT course_code FROM course WHERE courseName = '$course_code'),
                             '$course_code',
                             'Elective'
                         WHERE '$course_code' IS NOT NULL;";
                mysqli_query($con, $sql1);
                $sql2 = "UPDATE total_no_of_seats SET `$temp` = `$temp` - 1 WHERE stream_id = '".$_POST['stream_idx']."'";
                mysqli_query($con, $sql2);
                $tempseats--;
            }
        }
    }
    
// echo($row['studentRegno']);
// updating the status of that student that is enrolled
$sql1= "UPDATE students
SET enrolment_status_elective=1
WHERE studentRegno='".$row['studentRegno']."'; ";
mysqli_query($con,$sql1);
}


    //this is for removing duplicate values if the submit button is clicked more than once
    $sqln="DELETE FROM courses_allocated 
    WHERE courses_allocated_id NOT IN (
         SELECT MIN(courses_allocated_id)
         FROM courses_allocated
         GROUP BY student_reg_no, course_code
    )";
    mysqli_query($con,$sqln);
    
    
    echo '<script>alert("Electives allocated.")</script>';
    // var_dump($row);
}
if(isset($_POST['submitupdateConstraint'])) {
  $streamid = $_POST['stream_idx'];
  $course = $_POST['course_idx'];
  $newval = $_POST['newconstraint'];
  $escapedCourse = mysqli_real_escape_string($con, $course);
  $sql = mysqli_query($con, "UPDATE total_no_of_seats SET `$escapedCourse`='$newval' WHERE stream_id='$streamid'");

  $sql1=mysqli_query($con, "UPDATE students SET enrolment_status_elective = 0 WHERE stream_id = '$streamid'");
  $sql2=mysqli_query($con, "DELETE FROM courses_allocated  WHERE student_reg_no IN (    SELECT studentRegno    FROM students    WHERE stream_id = '$streamid'  )");
  echo '<script>alert("Constraints are updated and students are deallocated")</script>';
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
                        <h1 class="page-head-line">Allocation  </h1>
                    </div>
                </div>
                <div class="row" >
                  <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <div class="panel panel-default">
                        <div class="panel-heading">
                          Allocation
                        </div>
<font color="green" align="center"><?php echo htmlentities($_SESSION['msg']);?><?php echo htmlentities($_SESSION['msg']="");?></font>





                        <div class="panel-body">
                       <form method="post" >
   
                       <div class="form-group">
    <label for="stream_name">Select Stream</label>
    <select class="form-control" name="stream_idx" required="required">
   <option value="">Select Stream</option>   
   <?php 
$sql=mysqli_query($con,"select * from set_oc_electives");
while($row=mysqli_fetch_array($sql))
{
?>
<option value="<?php echo htmlentities($row['stream_id']);?>"><?php echo htmlentities($row['stream_name']);?></option>
<?php } ?>
    </select> 
   </div> 

 <button type="submit" name="submit" id="submit" class="btn btn-default">Allocate Optional Core</button>
</form>
<br>
<form method="post">
  <div class="form-group">
    <label for="stream_name">Select Stream</label>
    <select class="form-control" name="stream_idx" id="stream_idx" required="required">
      <option value="">Select Stream</option>
      <?php
      $sql = mysqli_query($con, "select * from set_oc_electives");
      while($row = mysqli_fetch_array($sql)) {
        ?>
        <option value="<?php echo htmlentities($row['stream_id']);?>"><?php echo htmlentities($row['stream_name']);?></option>
        <?php
      }
      ?>
    </select>
  </div>

  <div class="col-md-12">
    <!-- Bordered Table -->
    <div class="panel panel-default">
      <div class="panel-heading">
        Constraints
      </div>
      <!-- /.panel-heading -->
      <div class="panel-body">
        <div class="table-responsive table-bordered">
          <table class="table">
            <thead>
              <tr>
                <th>Index</th>
                <th>Course Name</th>
                <th>Allocated</th>
                <th>Constraint</th>
                <!-- <th>Updated Constraints</th> -->
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

  <script>
    $(document).ready(function() {
      var streamDropdown = $('#stream_idx');
      var courseTable = $('#courseTable');

      streamDropdown.on('change', function() {
        var selectedStreamId = $(this).val();
        // console.log(selectedStreamId);
        // Send AJAX request to fetch updated course data
        $.ajax({
          url: 'fetch_courses.php',
          method: 'POST',
          data: { stream_idx: selectedStreamId },
          success: function(response) {
            // Update the table content with the response
            courseTable.html(response);
          },
          error: function(xhr, status, error) {
            // Handle errors if necessary
            console.log(error);
          }
        });
      });
    });
  </script>




<form method="post" >
   
                       <div class="form-group">
                       <div class="col-md-12">
    <!-- Bordered Table -->
    <div class="panel panel-default">
        <div class="panel-heading">
            Update Constraints
        </div>
        <!-- /.panel-heading -->
        <div class="panel-body">
            <div class="form-group">
                <label for="course_name">Select Course</label>
                <select class="form-control" name="course_idx" id="course_idx" >
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
        var updatedConstraint = parseInt(response.trim()); // Parse the response value as an integer
        $('#updatedConstraintLabel').text(updatedConstraint); // Set the label text to the response value
        $('#newconstraint').attr('max', updatedConstraint); // Set the maximum value of the input field
        console.log(response);
      },
      error: function() {
        $('#updatedConstraintLabel').text('0'); // Set a default value if there is an error
        $('#newconstraint').attr('max', '0'); // Set the maximum value of the input field to 0
      }
    });
  });
});

</script> 

   </div> 
   <button type="submit" name="submitElective" id="submitElective" class="btn btn-default">Allocate Electives</button>
   <button type="submit" name="submitupdateConstraint" id="submitupdateConstraint" class="btn btn-default">Update Constraint</button>
</form>

<br>

</form>

                            </div>

                            
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
<?php } ?>

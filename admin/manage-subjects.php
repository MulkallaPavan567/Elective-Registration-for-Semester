<?php
session_start();
include('includes/config.php');
if(strlen($_SESSION['alogin']) == 0) {   
    header('location:index.php');
} else {
    if(isset($_POST['submit'])) {
        echo 'clicked';
        $fileName = $_FILES['csvFile']['name'];
        $fileTmpName = $_FILES['csvFile']['tmp_name'];
        $fileType = $_FILES['csvFile']['type'];
        $fileSize = $_FILES['csvFile']['size'];
        $fileError = $_FILES['csvFile']['error'];

        if ($fileError === 0) {
            $file = fopen($fileTmpName, "r");
            if ($file) {
                while (($data = fgetcsv($file)) !== FALSE) {
                    // Debug: Print data from CSV file
                    print_r($data);

                    $course_code = $data[0];
                    $courseName = $data[1];
                    $bucket_number = $data[2];
                    $seats_for_MCA = $data[3];
                    $seats_for_IMTECH_3_4 = $data[4];
                    $seats_for_IMTECH_5_6 = $data[5];
                    $seats_for_IMTECH_7_8 = $data[6];
                    $seats_for_MTECH_AI = $data[7];
                    $seats_for_MTECH_CS = $data[8];
                    $seats_for_MTECH_IT = $data[9];

                    // Insert data into the course table
                    $sql = "INSERT INTO course (course_code, courseName, bucket_number, seats_for_MCA, seats_for_IMTECH_3_4, seats_for_IMTECH_5_6, seats_for_IMTECH_7_8, seats_for_MTECH_AI, seats_for_MTECH_CS, seats_for_MTECH_IT) VALUES ('$course_code','$courseName','$bucket_number','$seats_for_MCA','$seats_for_IMTECH_3_4','$seats_for_IMTECH_5_6','$seats_for_IMTECH_7_8','$seats_for_MTECH_AI','$seats_for_MTECH_CS','$seats_for_MTECH_IT')";

                    $ret = mysqli_query($con, $sql);
                    if(!$ret) {
                        // Error handling: Print SQL error
                        echo "Error: " . mysqli_error($con);
                    } else {
                        echo "Data inserted successfully!";
                    }
                }
                fclose($file);
                echo "<script>alert('Data added to database successfully')</script>" . "<br>";
                echo '<META HTTP-EQUIV="Refresh" CONTENT="0; URL=http://localhost/electives/onlinecourse/admin/manage-subjects.php">';
            } else {
                echo "Error opening file";
            }
        } else {
            echo "<script>alert('Error importing file.')</script>" . "<br>";
            echo '<META HTTP-EQUIV="Refresh" CONTENT="0; URL=http://localhost/electives/onlinecourse/admin/manage-subjects.php">';
        }
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
    <title>Manage Subjects</title>
    <link href="../assets/css/bootstrap.css" rel="stylesheet" />
    <link href="../assets/css/font-awesome.css" rel="stylesheet" />
    <link href="../assets/css/style.css" rel="stylesheet" />
</head>
<body>
    <?php include('includes/header.php');?>
    <!-- LOGO HEADER END-->
    <?php include('includes/menubar.php');?>
    <!-- MENU SECTION END-->
    <div class="content-wrapper">
        <div class="container">
              <div class="row">
                    <div class="col-md-12">
                        <h1 class="page-head-line">Manage Electives / Optional Core Subjects  </h1>
                    </div>
                </div>
                <div class="row" >
                  <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Manage Electives / Optional Core Subjects
                            </div>
                            <font color="green" align="center"><?php echo htmlentities($_SESSION['msg']);?><?php echo htmlentities($_SESSION['msg']="");?></font>
                            <div class="panel-body">
                                <form name="dept" method="post" enctype="multipart/form-data">
                                    <label for="csvFile">Choose CSV file:</label>
                                    <input type="file" name="csvFile" id="csvFile"><br><br>
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
</body>
</html>

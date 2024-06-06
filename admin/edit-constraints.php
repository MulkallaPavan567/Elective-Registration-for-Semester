<?php
session_start();
include('includes/config.php');
error_reporting(0);
if (strlen($_SESSION['alogin']) == 0) {
    header('location:index.php');
} else {
    if (isset($_POST['submit'])) {
        $courseName = $_GET['courseName'];
        $seats_for_MCA = $_POST['seats_for_MCA'];
        $seats_for_MTECH_AI = $_POST['seats_for_MTECH_AI'];
        $seats_for_MTECH_CS = $_POST['seats_for_MTECH_CS'];
        $seats_for_MTECH_IT = $_POST['seats_for_MTECH_IT'];
        $seats_for_IMTECH_3_4 = $_POST['seats_for_IMTECH_3_4'];
        $seats_for_IMTECH_5_6 = $_POST['seats_for_IMTECH_5_6'];
        $seats_for_IMTECH_7_8 = $_POST['seats_for_IMTECH_7_8'];

        $ret = mysqli_query($con, "UPDATE course SET seats_for_MCA='$seats_for_MCA', seats_for_MTECH_AI='$seats_for_MTECH_AI', seats_for_MTECH_CS='$seats_for_MTECH_CS', seats_for_MTECH_IT='$seats_for_MTECH_IT', seats_for_IMTECH_3_4='$seats_for_IMTECH_3_4', seats_for_IMTECH_5_6='$seats_for_IMTECH_5_6', seats_for_IMTECH_7_8='$seats_for_IMTECH_7_8' WHERE courseName='$courseName'");
        if ($ret) {
            echo '<script>alert("Student Record updated Successfully !!")</script>';
            echo '<script>window.location.href="http://localhost/electives/onlinecourse/admin/allocation.php"</script>';
        } else {
            echo '<script>alert("Error : Student Record not update")</script>';
            echo '<script>window.location.href="http://localhost/electives/onlinecourse/admin/allocation.php"</script>';
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
        <title>Edit Seat count</title>
        <link href="../assets/css/bootstrap.css" rel="stylesheet" />
        <link href="../assets/css/font-awesome.css" rel="stylesheet" />
        <link href="../assets/css/style.css" rel="stylesheet" />
    </head>

    <body>
        <?php include('includes/header.php'); ?>
        <?php if ($_SESSION['alogin'] != "") {
            include('includes/menubar.php');
        } ?>
        <div class="content-wrapper">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <h1 class="page-head-line">Edit Seat Count</h1>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Constraints
                            </div>
                            <div class="panel-body">
                                <form name="dept" method="post" enctype="multipart/form-data">
                                    <?php
                                    $courseName = $_GET['courseName'];
                                    $sql = mysqli_query($con, "SELECT * FROM course WHERE courseName='$courseName'");
                                    while ($row = mysqli_fetch_array($sql)) {
                                    ?>
                                        <div class="form-group">
                                            <label for="courseName">Course Name</label>
                                            <input type="text" class="form-control" id="courseName" name="courseName" value="<?php echo htmlentities($row['courseName']); ?>" placeholder="CourseName" readonly />
                                        </div>
                                        <div class="form-group">
                                            <label for="seats_for_MCA">Seats for MCA</label>
                                            <input type="text" class="form-control" id="seats_for_MCA" name="seats_for_MCA" value="<?php echo htmlentities($row['seats_for_MCA']); ?>" />
                                        </div>
                                        <div class="form-group">
                                            <label for="seats_for_MTECH_AI">Seats for MTECH AI</label>
                                            <input type="text" class="form-control" id="seats_for_MTECH_AI" name="seats_for_MTECH_AI" value="<?php echo htmlentities($row['seats_for_MTECH_AI']); ?>" />
                                        </div>
                                        <div class="form-group">
                                            <label for="seats_for_MTECH_CS">Seats for MTECH CS</label>
                                            <input type="text" class="form-control" id="seats_for_MTECH_CS" name="seats_for_MTECH_CS" value="<?php echo htmlentities($row['seats_for_MTECH_CS']); ?>" />
                                        </div>
                                        <div class="form-group">
                                            <label for="seats_for_MTECH_IT">Seats for MTECH IT</label>
                                            <input type="text" class="form-control" id="seats_for_MTECH_IT" name="seats_for_MTECH_IT" value="<?php echo htmlentities($row['seats_for_MTECH_IT']); ?>" />
                                        </div>
                                        <div class="form-group">
                                            <label for="seats_for_IMTECH_3_4">Seats for IMTECH 3-4</label>
                                            <input type="text" class="form-control" id="seats_for_IMTECH_3_4" name="seats_for_IMTECH_3_4" value="<?php echo htmlentities($row['seats_for_IMTECH_3_4']); ?>" />
                                        </div>
                                        <div class="form-group">
                                            <label for="seats_for_IMTECH_5_6">Seats for IMTECH 5-6</label>
                                            <input type="text" class="form-control" id="seats_for_IMTECH_5_6" name="seats_for_IMTECH_5_6" value="<?php echo htmlentities($row['seats_for_IMTECH_5_6']); ?>" />
                                        </div>
                                        <div class="form-group">
                                            <label for="seats_for_IMTECH_7_8">Seats for IMTECH 7-8</label>
                                            <input type="text" class="form-control" id="seats_for_IMTECH_7_8" name="seats_for_IMTECH_7_8" value="<?php echo htmlentities($row['seats_for_IMTECH_7_8']); ?>" />
                                        </div>
                                    <?php } ?>
                                    <button type="submit" name="submit" id="submit" class="btn btn-default">Update</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <?php include('includes/footer.php'); ?>
        <script src="../assets/js/jquery-1.11.1.js"></script>
        <script src="../assets/js/bootstrap.js"></script>
    </body>

    </html>
<?php } ?>

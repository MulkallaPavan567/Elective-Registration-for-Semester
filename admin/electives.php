<?php
session_start();
include('includes/config.php');
error_reporting(0);
if (strlen($_SESSION['alogin']) == 0) {
    header('location:index.php');
} else {
    if (isset($_POST['submit'])) {
        $stream_id = $_POST['stream_id'];

        $sqln = mysqli_query($con, "SELECT stream_name FROM stream WHERE stream_id='$stream_id'");
        $rown = mysqli_fetch_array($sqln);
        $stream_name = $rown['stream_name'];

        $sql1 = mysqli_query($con, "SELECT studentRegno, stream_name, E1, E2, E3, E4, E5, E6, E7, E8, E9, E10, E11, E12, E13, E14, E15, E16, E17, E18, E19 FROM elective_preference WHERE stream_name='$stream_name'");

        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename=' . $stream_name . '_elective_preferences.csv');

        $output = fopen('php://output', 'w');
        fputcsv($output, array('studentRegno','stream_name','E1','E2','E3','E4','E5','E6','E7','E8','E9','E10','E11','E12','E13','E14','E15','E16','E17','E18','E19'));

        while ($row = mysqli_fetch_assoc($sql1)) {
            fputcsv($output, $row);
        }
        fclose($output);
        exit;
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
    <title>Dowload elective preferences</title>
    <link href="../assets/css/bootstrap.css" rel="stylesheet" />
    <link href="../assets/css/font-awesome.css" rel="stylesheet" />
    <link href="../assets/css/style.css" rel="stylesheet" />
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
                    <h1 class="page-head-line">Download Elective Preferences </h1>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Download Elective Preferences
                        </div>
                        <font color="green" align="center"><?php echo htmlentities($_SESSION['msg']); ?><?php echo htmlentities($_SESSION['msg'] = ""); ?></font>
                        <div class="panel-body">
                            <form method="post">
                                <div class="form-group">
                                    <label for="stream_name">Select Stream</label>
                                    <select class="form-control" name="stream_id" required="required" onchange="getCourseCode()">
                                        <option value="">Select Stream Name</option>
                                        <?php
                                        $sql = mysqli_query($con, "select * from stream");
                                        while ($row = mysqli_fetch_array($sql)) {
                                        ?>
                                            <option value="<?php echo htmlentities($row['stream_id']); ?>"><?php echo htmlentities($row['stream_name']); ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                                <button type="submit" name="submit" id="submit" class="btn btn-default">Download</button>
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

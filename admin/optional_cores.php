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

        $sql1 = mysqli_query($con, "SELECT studentRegno, course_name, optional_core_choice_1, optional_core_choice_2, optional_core_choice_3, optional_core_choice_4, optional_core_choice_5 FROM students WHERE stream_id='$stream_id'");

        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename=' . $stream_name . '_optional_core_preferences.csv');

        $output = fopen('php://output', 'w');
        fputcsv($output, array('Student Reg No', 'Course Name', 'Optional Core Choice 1', 'Optional Core Choice 2', 'Optional Core Choice 3', 'Optional Core Choice 4', 'Optional Core Choice 5'));

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
    <title>Download Optional core Preferences</title>
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
                    <h1 class="page-head-line">Download Optional cores Preferences</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Download Optional cores Preferences
                        </div>
                        <font color="green" align="center"><?php echo htmlentities($_SESSION['msg']); ?><?php echo htmlentities($_SESSION['msg'] = ""); ?></font>
                        <div class="panel-body">
                            <form method="post">
                                <div class="form-group">
                                    <label for="stream_name">Select Stream</label>
                                    <select class="form-control" name="stream_id" required="required" onchange="this.form.submit()">
                                        <option value="">Select Stream Name</option>
                                        <?php
                                        $sql = mysqli_query($con, "SELECT * FROM stream");
                                        while ($row = mysqli_fetch_array($sql)) {
                                            $selected = ($row['stream_id'] == $_POST['stream_id']) ? 'selected' : '';
                                        ?>
                                            <option value="<?php echo htmlentities($row['stream_id']); ?>" <?php echo $selected ?>><?php echo htmlentities($row['stream_name']); ?></option>
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

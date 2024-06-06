<?php
session_start();
include('includes/config.php');
if(strlen($_SESSION['alogin'])==0) {   
    header('location:index.php');
} else {
    if(isset($_POST['submit'])) {
        $stream_name = $_POST["stream_name"];
        $optional_cores_count = $_POST["optional_cores_count"];
        $electives = $_POST["electives"];
        
        // Fetching stream_id based on the selected stream_name
        $stmt = $con->prepare("SELECT stream_id FROM stream WHERE stream_name = ?");
        $stmt->bind_param("s", $stream_name);
        $stmt->execute();
        $stmt->bind_result($stream_id);
        $stmt->fetch();
        $stmt->close();
        
        // Prepare and bind SQL statement
        $stmt = $con->prepare("INSERT INTO set_oc_electives (stream_id, stream_name, optional_cores_count, electives) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("isii", $stream_id, $stream_name, $optional_cores_count, $electives);
        $ret = $stmt->execute();
        $stmt->close();
        
        if($ret) {
            echo '<script>alert("Data added to database Successfully.")</script>';
            echo '<script>window.location.href=No.of_OC_Electives.php</script>';
        } else {
            echo '<script>alert("Duplicate entry / Something went wrong. Please try again.")</script>';
            echo '<script>window.location.href=No.of_OC_Electives.php</script>';
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
    <title>SET Optional Core & Electives</title>
    <link href="../assets/css/bootstrap.css" rel="stylesheet" />
    <link href="../assets/css/font-awesome.css" rel="stylesheet" />
    <link href="../assets/css/style.css" rel="stylesheet" />

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
                    <h1 class="page-head-line">SET Optional Core & Electives</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">SET Optional Core & Electives</div>
                        <div class="panel-body">
                            <form name="dept" method="post">
                                <div class="form-group">
                                    <label for="stream_name">Stream Name</label>
                                    <select class="form-control" id="stream_name" name="stream_name" required>
                                        <option value="">Select Stream</option>
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
                                    <label for="optional_cores_count">Optional cores</label>
                                    <input type="number" class="form-control" id="optional_cores_count" name="optional_cores_count" placeholder="Enter no.of Optinal cores" required />
                                </div>
                                <div class="form-group">
                                    <label for="electives">Electives</label>
                                    <input type="number" class="form-control" id="electives" name="electives" onBlur="userAvailability()" placeholder="Enter no.of Electives" required />
                                    <span id="user-availability-status1" style="font-size:12px;"></span>
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
                data:'regno='+$("#electives").val(),
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
            $('#stream_name').change(function(){
                var streamName = $(this).val();
                $.ajax({
                    url: 'get_stream_id.php',
                    type: 'post',
                    data: {stream_name: streamName},
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
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
<?php 
 include('includes/menubar.php');
 ?>
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


                        <div class="panel-body">
                            <form action="insertion_subjects.php" method="POST" enctype="multipart/form-data">

                            <label for="csvfile">Choose CSV File:</label>
                            <input type="file" id="csvfile" name="csvfile" accept=".csv"><br><br>

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
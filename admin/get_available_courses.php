<?php
include('includes/config.php');

if (isset($_POST['bucket_number'])) {
    $bucketNumber = $_POST['bucket_number'];
    
    // Query the database to retrieve available courses based on the bucket number
    $sql = mysqli_query($con, "SELECT course_code, course_name FROM courses WHERE bucket_number = '$bucketNumber'");
    
    $courses = array();
    while ($row = mysqli_fetch_assoc($sql)) {
        $courses[] = $row;
    }
    
    echo json_encode($courses);
}
?>

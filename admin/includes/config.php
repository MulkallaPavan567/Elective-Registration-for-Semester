<?php
define('DB_SERVER','localhost');
define('DB_USER','root');
define('DB_PASS' ,'');
define('DB_NAME', 'onlinecourse');
define('DB_PORT', 3308);
$con = mysqli_connect(DB_SERVER,DB_USER,DB_PASS,DB_NAME,DB_PORT);
// Check connection
if (mysqli_connect_errno())
{
 echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
?>
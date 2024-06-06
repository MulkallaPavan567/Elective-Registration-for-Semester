<?php
// include('includes/config.php');

// if ($_POST['stream_idx']) {
//     $stream_id = $_POST['stream_idx'];
//     $stmt = mysqli_prepare($con, "SELECT * FROM course WHERE bucket_number IN (SELECT bucket_number FROM stream WHERE stream_id = ?)");
    
//     if ($stmt === false) {
//         die('mysqli_prepare error: ' . mysqli_error($con)); // Print error message and exit
//     }

//     mysqli_stmt_bind_param($stmt, 's', $stream_id);
//     mysqli_stmt_execute($stmt);
//     $result = mysqli_stmt_get_result($stmt);

//     $index = 1; // Initialize index variable


//     while ($row = mysqli_fetch_array($result)) {
//         echo '<tr>';
//         echo '<td>' . $index++ . '</td>';
//         echo '<td>' . htmlentities($row['courseName']) . '</td>';
//         echo '<td>'; // Start Allocated column
        
//         // Count the number of distinct student registration numbers allocated for this course
//         $course_code = $row['course_code'];
//         $allocated_query = "SELECT COUNT(DISTINCT student_reg_no) AS allocated_count FROM courses_allocated WHERE course_code = ?";
//         $allocated_stmt = mysqli_prepare($con, $allocated_query);

//         if ($allocated_stmt === false) {
//             die('mysqli_prepare error: ' . mysqli_error($con)); // Print error message and exit
//         }

//         mysqli_stmt_bind_param($allocated_stmt, 's', $course_code);
//         mysqli_stmt_execute($allocated_stmt);
//         $allocated_result = mysqli_stmt_get_result($allocated_stmt);
//         $allocated_row = mysqli_fetch_assoc($allocated_result);
//         echo $allocated_row['allocated_count']; // Display the count of allocated seats

//         echo '</td>'; // End Allocated column
//         echo '<td>'; // Start Constraint column
        
//         // Determine which column to use for constraint based on the selected stream
//         switch ($stream_id) {
//             case 1:
//                 $constraint = $row['seats_for_MCA'];
//                 break;
//             case 2:
//                 $constraint = $row['seats_for_MTECH_AI'];
//                 break;
//             case 3:
//                 $constraint = $row['seats_for_MTECH_CS'];
//                 break;
//             case 4:
//                 $constraint = $row['seats_for_MTECH_IT'];
//                 break;
//             case 5:
//                 $constraint = $row['seats_for_IMTECH_3_4'];
//                 break;
//             case 6:
//                 $constraint = $row['seats_for_IMTECH_5_6'];
//                 break;
//             case 7:
//                 $constraint = $row['seats_for_IMTECH_7_8'];
//                 break;
//             default:
//                 $constraint = 'Unknown Stream';
//         }
        
//         echo $constraint;

//         echo '</td>'; // End Constraint column
//         echo '</tr>';
//     }

//     echo '</tbody>';
//     echo '</table>';
// }
?>
<?php
include('includes/config.php');

if (isset($_POST['stream_idx'])) {
    $stream_id = $_POST['stream_idx'];
    $stmt = mysqli_prepare($con, "SELECT c.*, COUNT(DISTINCT ca.student_reg_no) AS allocated_count 
                                  FROM course c 
                                  LEFT JOIN courses_allocated ca ON c.courseName = ca.course_code 
                                  WHERE c.bucket_number IN (SELECT bucket_number FROM stream WHERE stream_id = ?)
                                  GROUP BY c.course_code");
    
    if ($stmt === false) {
        die('mysqli_prepare error: ' . mysqli_error($con)); // Print error message and exit
    }

    mysqli_stmt_bind_param($stmt, 'i', $stream_id);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

    $index = 1; // Initialize index variable

    // echo '<table class="table">';
    // echo '<thead>';
    // echo '<tr>';
    // echo '<th>Index</th>';
    // echo '<th>Course Name</th>';
    // echo '<th>Allocated</th>';
    // echo '<th>Constraint</th>';
    // echo '</tr>';
    // echo '</thead>';
    // echo '<tbody>';

    while ($row = mysqli_fetch_array($result)) {
        echo '<tr>';
        echo '<td>' . $index++ . '</td>';
        echo '<td>' . htmlentities($row['courseName']) . '</td>';
        echo '<td>' . $row['allocated_count'] . '</td>'; // Display the count of allocated seats
        echo '<td>'; // Start Constraint column
        
        // Determine which column to use for constraint based on the selected stream
        switch ($stream_id) {
            case 1:
                $constraint = $row['seats_for_MCA'];
                break;
            case 2:
                $constraint = $row['seats_for_MTECH_AI'];
                break;
            case 3:
                $constraint = $row['seats_for_MTECH_CS'];
                break;
            case 4:
                $constraint = $row['seats_for_MTECH_IT'];
                break;
            case 5:
                $constraint = $row['seats_for_IMTECH_3_4'];
                break;
            case 6:
                $constraint = $row['seats_for_IMTECH_5_6'];
                break;
            case 7:
                $constraint = $row['seats_for_IMTECH_7_8'];
                break;
            default:
                $constraint = 'Unknown Stream';
        }
        
        echo $constraint;

        echo '</td>'; // End Constraint column
        echo '</tr>';
    }

    echo '</tbody>';
    echo '</table>';
}
?>

<?php
// include('includes/config.php');

// if (isset($_POST['stream_idx'])) {
//     $stream_id = $_POST['stream_idx'];
//     // $stmt = mysqli_prepare($con, "SELECT c.*, COUNT(DISTINCT ca.student_reg_no) AS allocated_count 
//     //                               FROM course c 
//     //                               LEFT JOIN courses_allocated ca ON c.courseName = ca.courseName 
//     //                               WHERE ca.stream_name IN (SELECT stream_name FROM stream WHERE stream_id = ?)
//     //                               AND (c.seats_for_MCA > 0 OR c.seats_for_MTECH_AI > 0 OR c.seats_for_MTECH_CS > 0 OR c.seats_for_MTECH_IT > 0 OR c.seats_for_IMTECH_3_4 > 0 OR c.seats_for_IMTECH_5_6 > 0 OR c.seats_for_IMTECH_7_8 > 0)
//     //                               AND ca.course_type='Elective'
//     //                               GROUP BY c.course_code");

//     $stmt = mysqli_prepare($con, "SELECT c.courseName, 
//                                      IFNULL(COUNT(DISTINCT ca.student_reg_no), 0) AS allocated_count
//                               FROM course c
//                               LEFT JOIN courses_allocated ca ON c.courseName = ca.courseName AND ca.stream_name IN (SELECT stream_name FROM stream WHERE stream_id = ?) AND ca.course_type='Elective'
//                               WHERE (c.seats_for_MCA > 0 OR c.seats_for_MTECH_AI > 0 OR c.seats_for_MTECH_CS > 0 OR c.seats_for_MTECH_IT > 0 OR c.seats_for_IMTECH_3_4 > 0 OR c.seats_for_IMTECH_5_6 > 0 OR c.seats_for_IMTECH_7_8 > 0)
//                               GROUP BY c.course_code");
//     if ($stmt === false) {
//         die('mysqli_prepare error: ' . mysqli_error($con)); // Print error message and exit
//     }

//     mysqli_stmt_bind_param($stmt, 'i', $stream_id);
//     mysqli_stmt_execute($stmt);
//     $result = mysqli_stmt_get_result($stmt);

//     $index = 1; // Initialize index variable


//     while ($row = mysqli_fetch_array($result)) {
//         echo '<tr>';
//         echo '<td>' . $index++ . '</td>';
//         echo '<td>' . htmlentities($row['courseName']) . '</td>';
//         echo '<td>' . $row['allocated_count'] . '</td>'; // Display the count of allocated seats
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

    $stmt = mysqli_prepare($con, "SELECT c.courseName, 
                                         IFNULL(COUNT(DISTINCT ca.student_reg_no), 0) AS allocated_count,
                                         c.seats_for_MCA,
                                         c.seats_for_MTECH_AI,
                                         c.seats_for_MTECH_CS,
                                         c.seats_for_MTECH_IT,
                                         c.seats_for_IMTECH_3_4,
                                         c.seats_for_IMTECH_5_6,
                                         c.seats_for_IMTECH_7_8
                                  FROM course c
                                  LEFT JOIN courses_allocated ca ON c.courseName = ca.courseName AND ca.stream_name IN (SELECT stream_name FROM stream WHERE stream_id = ?) AND ca.course_type='Elective'
                                  WHERE (c.seats_for_MCA > 0 OR c.seats_for_MTECH_AI > 0 OR c.seats_for_MTECH_CS > 0 OR c.seats_for_MTECH_IT > 0 OR c.seats_for_IMTECH_3_4 > 0 OR c.seats_for_IMTECH_5_6 > 0 OR c.seats_for_IMTECH_7_8 > 0)
                                  GROUP BY c.course_code");

    if ($stmt === false) {
        die('mysqli_prepare error: ' . mysqli_error($con)); // Print error message and exit
    }

    mysqli_stmt_bind_param($stmt, 'i', $stream_id);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

    $index = 1; // Initialize index variable

    // echo '<table>';
    // echo '<thead>';
    // echo '<tr>';
    // echo '<th>Index</th>';
    // echo '<th>Course Name</th>';
    // echo '<th>Allocated Count</th>';
    // echo '<th>Constraint</th>';
    // echo '</tr>';
    // echo '</thead>';
    // echo '<tbody>';

    while ($row = mysqli_fetch_array($result)) {
        echo '<tr>';
        echo '<td>' . $index++ . '</td>';
        echo '<td>' . htmlentities($row['courseName']) . '</td>';
        echo '<td>' . $row['allocated_count'] . '</td>'; // Display the count of allocated seats

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

        echo '<td>' . $constraint . '</td>'; // Display the constraint column
        // echo '<td>
        //         <a href="edit-constraints.php?id=' . urlencode($row['courseName']) . '" >
        //             <button class="btn btn-primary"><i class="fa fa-edit"></i> Edit</button>
        //         </a>
        //     </td>';

        echo '</tr>';
    }

    echo '</tbody>';
    echo '</table>';
}
?>
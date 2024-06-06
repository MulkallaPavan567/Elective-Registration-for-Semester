<?php
// // fetch_seat_count.php

// include('includes/config.php');
// // Perform necessary database connection and configuration

// if (isset($_POST['course']) && isset($_POST['stream_idx'])) {
//     $selectedCourse = $_POST['course'];
//     $selectedStreamId = $_POST['stream_idx'];

//     $escapedCourse = mysqli_real_escape_string($con, $selectedCourse);

//     // Use prepared statements to prevent SQL injection
//     $stmt = mysqli_prepare($con, "SELECT TotalnoofSeats FROM course WHERE courseName = ?");
//     mysqli_stmt_bind_param($stmt, "s", $escapedCourse);
//     mysqli_stmt_execute($stmt);
//     $result = mysqli_stmt_get_result($stmt);

//     $stmt1 = mysqli_prepare($con, "SELECT count(*) AS cc FROM courses_allocated WHERE course_type='Elective' AND course_name = ? GROUP BY course_name");
//     mysqli_stmt_bind_param($stmt1, "s", $escapedCourse);
//     mysqli_stmt_execute($stmt1);
//     $result1 = mysqli_stmt_get_result($stmt1);



//     if ($row = mysqli_fetch_array($result) ) {
//         $row1=mysqli_fetch_array($result1);
//         $seatCount = $row['TotalnoofSeats']-($row1['cc'] ?? 0);
//         echo $seatCount;
    
//     } else {
//         echo "0"; // Default value if seat count is not found
//     }
// }
?>
<?php
include('includes/config.php');

if (isset($_POST['course']) && isset($_POST['stream_idx'])) {
    $selectedCourse = $_POST['course'];
    $selectedStreamId = $_POST['stream_idx'];

    // Use prepared statements to prevent SQL injection
    $stmt = mysqli_prepare($con, "SELECT seats_for_MCA, seats_for_MTECH_AI, seats_for_MTECH_CS, seats_for_MTECH_IT, seats_for_IMTECH_3_4, seats_for_IMTECH_5_6, seats_for_IMTECH_7_8, FROM course WHERE courseName = ?");
    mysqli_stmt_bind_param($stmt, "s", $selectedCourse);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

    if ($row = mysqli_fetch_assoc($result)) {
        // Calculate total seat count for the selected course
        $totalSeats = array_sum($row);
        
        // Count the number of allocations for the selected course
        // $stmtAlloc = mysqli_prepare($con, "SELECT COUNT(*) AS cc FROM courses_allocated WHERE course_type = 'Elective' AND course_name = ? GROUP BY course_name");
        $stmtAlloc = mysqli_prepare($con, "SELECT c.*, COUNT(DISTINCT ca.student_reg_no) AS allocated_count 
                                  FROM course c 
                                  LEFT JOIN courses_allocated ca ON c.courseName = ca.course_code 
                                  WHERE c.bucket_number IN (SELECT bucket_number FROM stream WHERE stream_id = ?)
                                  AND (c.seats_for_MCA > 0 OR c.seats_for_MTECH_AI > 0 OR c.seats_for_MTECH_CS > 0 OR c.seats_for_MTECH_IT > 0 OR c.seats_for_IMTECH_3_4 > 0 OR c.seats_for_IMTECH_5_6 > 0 OR c.seats_for_IMTECH_7_8 > 0)
                                  GROUP BY c.course_code");
        mysqli_stmt_bind_param($stmtAlloc, "s", $selectedCourse);
        mysqli_stmt_execute($stmtAlloc);
        $resultAlloc = mysqli_stmt_get_result($stmtAlloc);
        
        if ($rowAlloc = mysqli_fetch_assoc($resultAlloc)) {
            $allocatedSeats = $rowAlloc['cc'];
        } else {
            $allocatedSeats = 0;
        }

        // Calculate available seats by subtracting allocated seats from total seats
        $availableSeats = $totalSeats - $allocatedSeats;
        echo $availableSeats;
    } else {
        echo "0"; // Default value if course is not found
    }
}
?>


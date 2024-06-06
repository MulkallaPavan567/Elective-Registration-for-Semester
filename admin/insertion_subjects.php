<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $con = new mysqli('127.0.0.1:3308', 'root', '', 'onlinecourse');

    // Check connection
    if ($con->connect_error) {
        die("connection failed: " . $con->connect_error);
    }

    $success = true; // Track if all insertions are successful

    // Process the uploaded CSV file
    if (isset($_FILES["csvfile"]) && $_FILES["csvfile"]["error"] == 0) {
        $file = $_FILES["csvfile"]["tmp_name"];

        // Start a transaction
        $con->begin_transaction();

        try {
            // Read CSV file
            if (($handle = fopen($file, "r")) !== false) {
                while (($data = fgetcsv($handle, 1000, ",")) !== false) {
                    $course_code = $data[0];
                    $courseName = $data[1];
                    // $faculty_name = $data[2];
                    $bucket_number = $data[2];
                    $seats_for_MCA = $data[3];
                    $seats_for_IMTECH_3_4 = $data[4];
                    $seats_for_IMTECH_5_6 = $data[5];
                    $seats_for_IMTECH_7_8 = $data[6];
                    $seats_for_MTECH_AI = $data[7];
                    $seats_for_MTECH_CS = $data[8];
                    $seats_for_MTECH_IT = $data[9];

                    // Check if the book with the same ISBN already exists
                    $existingQuery = "SELECT * FROM courses WHERE course_code = '$course_code'";
                    $existingResult = $con->query($existingQuery);

                    if ($existingResult->num_rows == 0) {
                        // If the book doesn't exist, insert data into the "add_new_books" table
                        $sql = "INSERT INTO courses (course_code, courseName, bucket_number, seats_for_MCA, seats_for_IMTECH_3_4, seats_for_IMTECH_5_6, seats_for_IMTECH_7_8, seats_for_MTECH_AI, seats_for_MTECH_CS, seats_for_MTECH_IT) VALUES ('$course_code', '$courseName', '$faculty_name', '$bucket_number', '$seats_for_MCA', '$seats_for_IMTECH_3_4', '$seats_for_IMTECH_5_6', '$seats_for_IMTECH_7_8', '$seats_for_MTECH_AI', '$seats_for_MTECH_CS', '$seats_for_MTECH_IT')";

                        if ($con->query($sql) !== true) {
                            $success = false; // Set to false on the first error
                            throw new Exception("Error inserting subjects: " . $con->error);
                        }
                    } else {
                        // If the book already exists, show a message
                        echo "Subject with Course code: $course_code already exists. Skipping.<br>";
                    }
                }
                fclose($handle);
            }

            // Commit the transaction
            $con->commit();

            if ($success) {
                echo "<script>alert('Data added to database successfully')</script>" . "<br>";
                echo '<META HTTP-EQUIV="Refresh" CONTENT="0; URL=http://localhost/electives/onlinecourse/admin/manage-subjects.php">';
            } else {
                echo "<script>alert('Error: Added all books except duplicate entries')</script>";
                echo '<META HTTP-EQUIV="Refresh" CONTENT="0; URL=http://localhost/electives/onlinecourse/admin/manage-subjects.php">';
            }
        } catch (Exception $e) {
            // Rollback the transaction on exception
            $con->rollback();
            echo "<script>alert('Error: {$e->getMessage()}')</script>";
            echo '<META HTTP-EQUIV="Refresh" CONTENT="0; URL=http://localhost/electives/onlinecourse/admin/manage-subjects.php">';
        }
    }

    $con->close();
}
?>

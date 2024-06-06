<?php
// Database connection parameters
include('includes/config.php');

// If form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $streamName = $_POST["stream_name"];
    $optionalCores = $_POST["optional_cores"];
    $electives = $_POST["electives"];

    // Prepare and bind SQL statement
    $stmt = $conn->prepare("INSERT INTO No_of_OC_Electives (stream_name, Optional_Cores, Electives) VALUES (?, ?, ?)");
    $stmt->bind_param("sss", $streamName, $optionalCores, $electives);

    // Execute the statement
    if ($stmt->execute() === TRUE) {
        echo "New record created successfully";
    } else {
        echo "Error: " . $stmt->error;
    }

    // Close statement
    $stmt->close();
}

?>

<!DOCTYPE html>
<html>
<head>
    <title>Upload Data</title>
</head>
<body>

<h2>Upload Data to No. of OC/Electives Table</h2>
<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
    <label for="stream_name">Stream Name:</label>
    <select id="stream_name" name="stream_name">
        <option value="MCA">MCA</option>
        <option value="MTECH_AI">MTECH_AI</option>
        <option value="MTECH_CS">MTECH_CS</option>
        <option value="MTECH_IT">MTECH_IT</option>
        <option value="IMTECH 3-4">IMTECH 3-4</option>
        <option value="IMTECH 5-6">IMTECH 5-6</option>
        <option value="IMTECH 7-8">IMTECH 7-8</option>
    </select>
    <br><br>
    <label for="optional_cores">Optional Cores:</label>
    <input type="text" id="optional_cores" name="optional_cores">
    <br><br>
    <label for="electives">Electives:</label>
    <input type="text" id="electives" name="electives">
    <br><br>
    <input type="submit" value="Submit">
</form>

</body>
</html>

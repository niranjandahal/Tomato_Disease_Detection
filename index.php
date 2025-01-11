<?php
include 'cors.php';

// Check if image data is received
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['image'])) {
    // Get the image data
    $imageData = file_get_contents($_FILES['image']['tmp_name']);

    // Set up cURL to send the image data to your Flask server
    $url = 'http://127.0.0.1:5000/predict'; // Your Flask server URL
    $headers = array('Content-Type:multipart/form-data');
    $postData = array('file' => new CURLFile($_FILES['image']['tmp_name'], $_FILES['image']['type'], $_FILES['image']['name']));

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

    // Execute the cURL request
    $response = curl_exec($ch);
    $httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    // Check if the request was successful
    if ($httpcode == 200) {
        // Forward the response from Flask server to the Flutter app
        echo intval($response);
    } else {
        // Handle the error if the request fails
        echo json_encode(['error' => 'Failed to send image to Flask server']);
    }
} else {
    // Return an error response if no image data is received
    http_response_code(400);
    echo json_encode(['error' => 'No image data received']);
}

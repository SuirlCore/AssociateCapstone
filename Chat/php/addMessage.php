<?php
include 'chat_pdo.php';

$message = $_REQUEST["m"];
$date = $_REQUEST["d"];
$time = $_REQUEST["t"];
$user = $_REQUEST["u"];
$chat = $_REQUEST["c"];

$sql = "CALL newChatMessage('". $message. "', '". $user. "', ". $chat. ", '". $date. "', '". $time. "');";
mysqli_query($pdo, $sql);

?>
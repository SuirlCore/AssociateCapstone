<?php
//calls the lastMessage procedure from the database

include 'chat_pdo.php';

$chat = $_REQUEST["c"];
$user = $_REQUEST["u"];
$messages = array();


$sql = "CALL lastMessage(". $chat. ", '". $user. "');";

$run = mysqli_query($pdo, $sql);

while($row = mysqli_fetch_array($run, MYSQLI_NUM)){
	array_push($messages, $row[0]);
   }

$output = implode(">", $messages);

echo $output;

?>
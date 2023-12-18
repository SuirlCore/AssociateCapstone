<?php
//calls the checkRequests procedure from the database

include 'chat_pdo.php';

$requests = array();

$sql = "CALL checkRequests();";

$run = mysqli_query($pdo, $sql);

while($row = mysqli_fetch_array($run, MYSQLI_NUM)){
	array_push($requests, $row[0]);
   }

$output = implode("!@#$", $requests);

echo $output;

?>
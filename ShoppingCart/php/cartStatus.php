<?php
//calls the cartStatus procedure from the database

include '../../chat/php/chat_pdo.php';

$carts = array();

$sql = "CALL cartStatus();";

$run = mysqli_query($pdo, $sql);

while($row = mysqli_fetch_array($run, MYSQLI_NUM)){
	array_push($carts, $row[0]);
   }

$output = implode("!@#$", $carts);

echo $output;

?>
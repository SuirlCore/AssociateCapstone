<?php
include '../../chat/php/chat_pdo.php';

$itemNum = $_REQUEST["i"];
$userName = $_REQUEST["u"];

$sql = "CALL addtoCart(". $itemNum. ", '". $userName. "');";
mysqli_query($pdo, $sql);

?>
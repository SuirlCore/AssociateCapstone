<?php
include '../../chat/php/chat_pdo.php';

$instanceNum = $_REQUEST["i"];

$sql = "CALL removeFromCart(". $instanceNum. ");";
mysqli_query($pdo, $sql);

echo $sql;

return;

?>
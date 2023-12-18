<?php 
    session_start();
	include 'chat/php/chat_pdo.php';

	unset($_SESSION['user_name']);
	unset($_SESSION['chatID']);
	
	//When form posted, perform this code
    if(isset($_POST['user_name'])){
			
		//save the post variables to a local variable
		$userName = $_POST['user_name'];
		
		//call the add user sql procedure
		$sql = "CALL newUser('". $userName. "');";
		mysqli_query($pdo, $sql);		
		
		//set the user name variable
		$_SESSION['user_name'] = $_POST['user_name'];
		
		//send the user off to productList.php
		header('location: shoppingCart/productList.php');
		return;
	}
?>

<!DOCTYPE html> 
<html>
<title>Foxy Photography - Website Login</title> 
<head>
</head> 
<body>
    <form name="loginForm" action="login.php" method="POST">
		<h3>Enter your Name:</h3>
		<input type="text" name="user_name" value="">
		<br>
		<input type="submit" name="Submit" id="Submit" value="Submit">
	</form>
</body> 
</html>
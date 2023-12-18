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
		
		//send the user off to repScreen.php
		header('location: repScreen.php');
		return;
	}
?>   

<!DOCTYPE html> 
<html>
<title>Foxy Photography - Representative Login</title> 
<head>
</head> 
<body>
<p>Login to the representative screen:</p>
    <form name="loginForm" action="repLogin.php" method="POST">
		<h3>Enter your Name:</h3>
		<input type="text" name="user_name">
		<br>
		<input type="submit" name="Submit" id="Submit" value="Submit">
	</form>
</body> 
</html>


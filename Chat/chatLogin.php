<?php 
    session_start();
	include 'php/chat_pdo.php';
	
	echo "Name: ", $_SESSION['user_name'], '<br>';
	
	//When form posted, perform this code
    if(isset($_POST['chatID'])){
			
		//save the post variables to a local variable
		$userName = $_SESSION['user_name'];
		$chatIdent = $_POST['chatID'];		
	
		//call sql stored procedure to get a new chat id from the database if a chat id was not entered
		if ($chatIdent == "1") {
			echo "chatID = 1<br>";
			//call stored procedure
			$sql = "CALL newChatID('". $userName. "', @newChatID);";
			echo $sql;
			echo "<br>";
			$newChatID = mysqli_query($pdo, $sql);
			
			//change the array to a string
			$newChatIDString = mysqli_fetch_assoc($newChatID);
			foreach($newChatIDString as $row) {
				//set the session variable for chatID to the one from the database
				$_SESSION['chatID'] = $row;
			}
		}
		
		//set the session variable for chatID to the one entered.
		else {
			echo "chatID != 1<br>";
			$_SESSION['chatID'] = $_POST['chatID'];
		}
		
		//call enterChat() procedure
		$sql = "CALL enterChat(". $_POST['chatID']. ", '". $userName. "');";
		mysqli_query($pdo, $sql);
		
		//send the user off to chat.php
		header('location: chat.php');
		return;
	}
?>   

<!DOCTYPE html> 
<html>
<title>Foxy Photography - Chat Request Login</title> 
<head>
</head> 
<body>
    <form name="loginForm" action="chatLogin.php" method="POST">
		<h3>Request to chat with a representative:</h3><br>
		<p>
		If you have a chat Id, enter it in the text box below. <br>
		If you are initiating a chat with a representative, leave this field on 1.<br>
		<input type="text" name="chatID" value="1">
		</p>
		<br>
		<input type="submit" name="Submit" id="Submit" value="Submit">
	</form>
</body> 
</html>


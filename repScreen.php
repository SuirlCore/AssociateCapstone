<?php 
session_start();
include 'chat/php/chat_pdo.php';

echo "Name: ", $_SESSION['user_name'], '<br>';
?>

<!DOCTYPE html> 
<html>
<title>Foxy Photography - Representative Screen</title> 
<head>
	<link rel="stylesheet" href="chat/css/chat.css">
</head> 

<body>
	<script src="chat/js/checkRequests.js"></script>
	<script src="shoppingCart/js/cartStatus.js"></script>
	<script>
		//pull the userName from the session variable
		var jsUser = "<?php echo $_SESSION['user_name'];?>";
		
		var timer;
		timer = setInterval(function() {
			console.log("checkRequests()");
			checkRequests();
			cartStatus();
		}, 3000);
	</script>

	<h1>Representative Screen<br></h1>
	<br>
	
	<p>Users that are requesting to chat with a representative:</p>
	<br>
	
	<div id="userRequests" class="scrollbar">
	
	</div>
	
	<p>
	Click the link to chats, and type in the chatID to connect with the customer.
	<a href="chat/chatLogin.php">Foxy Photography Chats Login</a>
	</p>
	
	<br>
	<br>
	
	<h1>Shopping Cart Status:</h1>
	
	<p>Current Unordered Shopping Carts</p>
	<div id="cartStatus" class="scrollbar">
	
	</div>
	
</body> 

</html>
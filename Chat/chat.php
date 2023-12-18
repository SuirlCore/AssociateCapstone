<?php 
session_start();
include 'php/chat_pdo.php';

if(isset($_REQUESTS['c'])){
	$_SESSION['chatID'] = $_REQUESTS['c'];
}

echo "Name: ", $_SESSION['user_name'], '<br>';
echo "Chat id: ", $_SESSION['chatID'];
?>

<!DOCTYPE html> 
<html>
<title>Foxy Photography - Chat</title> 
<head>
	<link rel="stylesheet" href="css/chat.css">
</head> 
<body>
	<h1>Chat with a representative <br></h1>
	<script src="js/newMessage.js"></script>
	<script src="js/updateScreen.js"></script>
	<script>
		//pull the userName and chatID from the session variable
		var jsUser = "<?php echo $_SESSION['user_name'];?>";
		var jsChatID = "<?php echo $_SESSION['chatID'];?>";
		
		var timer;
		timer = setInterval(function() {
			updateScreen();
		}, 3000);
	</script>
	
	<div id="message" class="scrollBar">
	<ul id="messageList">
		<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		<li>A representative will be with you shortly. Please type your question and hit send to get started. </li>
	</ul>
	</div>
		
	<br>
	
	<label>Type your question and click "Submit".</label><br>
	
	<input type="text" id="enteredText">
	<button id="submit" onclick = "addNodeToDatabase()">Submit</button>

	<p>
		Click here to leave the chat and go back to the product list: <br>
		<a href="../shoppingcart/productList.php">Foxy Photography Products</a>
	</p>

	<script>
		//tell the form to submit if the enter key is pressed while in the text box.
		var textBox = document.getElementById("enteredText");
		
		textBox.addEventListener("keypress", function(event) {
			if (event.key === "Enter") {
				document.getElementById("submit").click();
			}
		});
	</script>
	
</body> 
</html>

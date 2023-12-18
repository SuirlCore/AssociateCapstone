<?php 
    session_start();
	include '../chat/php/chat_pdo.php';
	
	//get the contents of the users unordered cart from the database
	$cart = array();
	$sql = "CALL getCart('". $_SESSION['user_name']. "');";
	$run = mysqli_query($pdo, $sql);

	while($row = mysqli_fetch_array($run, MYSQLI_NUM)){
		array_push($cart, $row[0]);
	}
	
	$allItemsInCart = implode("!@#$", $cart);
	
	echo "Name: ". $_SESSION['user_name']. "<br>";	
?>

<!DOCTYPE html> 
<html>
<title>Foxy Photography - Shopping Cart</title> 
<head>
</head> 
<body>
	<script src="js/removeFromCart.js"></script>

    <p>
	Click this link to request to chat with a representative: <br>
	<a href="../chat/chatLogin.php">Foxy Photography Chats Login</a>
	</p>

	<p>
		Go back to the product list: <br>
		<a href="productList.php">Product List</a>
	</p>

	<h1>Contents of Shopping Cart:</h1>

	<div id="cartContents" class="scrollbar">
	
	<div>

	<script>
		//grab the allItemsInCart PHP variable into JavaScript
		let jsAllItemsInCart = "<?php echo $allItemsInCart; ?>";
		
		//split the string grabbed into separate items
		const allItemsInCartArray = jsAllItemsInCart.split("!@#$");

		//for each request in the array, add a DOM element
		let i = 0;
		while (i <allItemsInCartArray.length) {
			
			//slice the item number out of the string
			const instanceNum = allItemsInCartArray[i].slice(0,4);
			
			//create HTML code for each product listing
			let htmlText = allItemsInCartArray[i] + "<button onclick = 'removeFromCart(" + instanceNum + ")' > Remove From Cart </button><br><br>";
			
			//add the product to the DOM
			let node = document.createElement("LI");
			let textNode = document.createTextNode(htmlText);
			document.getElementById("cartContents").innerHTML += htmlText;
			i = i + 1;
		}



	</script>
</body> 
</html>
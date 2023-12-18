<?php 
	include '../chat/php/chat_pdo.php';

    session_start();
	echo "Name: ", $_SESSION['user_name'], '<br>';

	//query the database for productlist
	$products = array();
	$sql = "CALL getProducts();";
	$run = mysqli_query($pdo, $sql);

	while($row = mysqli_fetch_array($run, MYSQLI_NUM)){
		array_push($products, $row[0]);
	}

	$allProducts = implode("!@#$", $products);
?>

<!DOCTYPE html> 
<html>
<title>Foxy Photography - List of Products</title> 
<head>
</head> 

<body>
	<script src="js/addtocart.js"></script>

	<a href="shoppingCart.php">My Cart</a><br>
	
	<p>
	Click this link to request to chat with a representative: <br>
	<a href="../chat/chatLogin.php">Foxy Photography Chats Login</a>
	</p>

	<h1>Current list of products offered:</h1>
	
	<div id="productList" class="scrollbar">

	<div>

	<script>
		//load contents of the products table from the database, with html formatting

		// grab the userName from PHP
		var jsUser = "<?php echo $_SESSION['user_name'];?>";

		//grab the php variable
		let allProducts = "<?php echo $allProducts; ?>";
		
		//split the string grabbed into separate items
		const products = allProducts.split("!@#$");
	
		//for each request in the array, add a DOM element
		let i = 0;
		while (i < products.length) {
			
			//slice the item number out of the string
			const itemNum = products[i].slice(0,4);
			
			//create HTML code for each product listing
			let htmlText = products[i] + "<button onclick = 'addtoCart(" + itemNum + ")' > Add to Cart </button><br><br>";
			
			//add the product to the DOM
			let node = document.createElement("LI");
			let textNode = document.createTextNode(htmlText);
			document.getElementById("productList").innerHTML += htmlText;
			i = i + 1;
		}
		
	</script>
</body> 
</html>
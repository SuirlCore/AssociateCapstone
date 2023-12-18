//shows all unordered carts with user name, cartID, and total price of cart
function cartStatus() {
		console.log("cartStatus()");
	
	//make an ajax request to the database to find user chat requests
	var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {

			//split the string grabbed into separate requests
			let textString = this.responseText;
			const openCarts = textString.split("!@#$");

			//remove all current nodes from the div element before we add new ones
			let cartStatus = document.getElementById("cartStatus");
			cartStatus.innerHTML = null;

			//for each request in the array, add a DOM element
			let i = 0;
			while (i < openCarts.length) {
				let node = document.createElement("LI");
				let textNode = document.createTextNode(openCarts[i]);
				node.appendChild(textNode);
				document.getElementById("cartStatus").appendChild(node);
				i = i + 1;
			}
		}
    };
    xmlhttp.open("GET", "https://reliably-apt-buzzard.ngrok-free.app/IT299/ShoppingCart/php/cartStatus.php", true);
    xmlhttp.send();
}
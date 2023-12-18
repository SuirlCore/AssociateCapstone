//adds a product to the customers cart
function addtoCart(itemNum) {
	console.log("addtoCart(" + itemNum + ")");
	
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.open("POST", "php/addtoCart.php?i=" + itemNum + "&u=" + jsUser, true);
	xmlhttp.send();
}
//removes a product from the customers cart
function removeFromCart(instanceNum) {
	console.log("removeFromCart(" + instanceNum + ")");
	
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.open("POST", "php/removeFromCart.php?i=" + instanceNum, true);
	xmlhttp.send();

	setTimeout(function(){
		location.reload();
	}, 1000)
}
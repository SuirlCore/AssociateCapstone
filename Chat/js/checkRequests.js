//shows all chat requests that have not been answered
function checkRequests() {
		console.log("checkRequests()");
	
	//make an ajax request to the database to find user chat requests
	var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {

			//split the string grabbed into separate requests
			let textString = this.responseText;
			const requests = textString.split("!@#$");

			//remove all current nodes from the div element before we add new ones
			let userRequests = document.getElementById("userRequests");
			userRequests.innerHTML = null;

			//for each request in the array, add a DOM element
			let i = 0;
			while (i < requests.length) {
				let node = document.createElement("LI");
				let textNode = document.createTextNode(requests[i]);
				node.appendChild(textNode);
				document.getElementById("userRequests").appendChild(node);
				i = i + 1;
			}
		}
    };
    xmlhttp.open("GET", "https://reliably-apt-buzzard.ngrok-free.app/IT299/Chat/php/checkRequests.php", true);
    xmlhttp.send();
}
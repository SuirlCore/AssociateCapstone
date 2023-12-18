function updateScreen() {
	console.log("updateScreen()");
	
	//make an ajax request to the database to find new messages
	var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {

			//split the string grabbed into separate messages
			let textString = this.responseText;
			console.log(textString);
			const messages = textString.split(">");

			//for each message in the array, add a DOM element
			let i = 0;
			while (i < messages.length) {
				let node = document.createElement("LI");
				let textNode = document.createTextNode(messages[i]);
				node.appendChild(textNode);
				document.getElementById("messageList").appendChild(node);
				i = i + 1;
			}
		}
    };
    xmlhttp.open("GET", "php/checkDatabase.php?c=" + jsChatID + "&u=" + jsUser, true);
    xmlhttp.send();
}
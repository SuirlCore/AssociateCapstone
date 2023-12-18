function addNodeToDatabase() {
	
	//pull the value of the text box as a variable, then clear the box.
	var message = document.getElementById("enteredText").value;
	document.getElementById('enteredText').value=''
	
	//create date and time stamps
	var currentdate = new Date(); 
	var date = currentdate.getDate() + "/"
				+ (currentdate.getMonth()+1)  + "/" 
				+ currentdate.getFullYear();
	var time = currentdate.getHours() + ":"  
				+ currentdate.getMinutes() + ":" 
				+ currentdate.getSeconds();
	var dateTime = date + " @ " + time;
	
	//call the addMessage.php script to update the database with the new message using AJAX
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.open("POST", "php/addMessage.php?m=" + message + "&d=" + date + "&t=" + time + "&u=" + jsUser + "&c=" + jsChatID, true);
	xmlhttp.send();
}
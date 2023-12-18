-- ------------------------------------------------------------------------------------------
-- create database---------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------


DROP DATABASE IF EXISTS chats;

CREATE DATABASE chats;

USE chats;


-- ------------------------------------------------------------------------------------------
-- Chat tables-------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS messages (
	messageID int NOT NULL AUTO_INCREMENT,
	message char(255) NOT NULL,
  	userID int NOT NULL,
	chatID int NOT NULL,
	seenByU1 char(5),
	SeenByU2 char(5),
	stampDate char(255),
	stampTime char(255),
    PRIMARY KEY (messageID)
);

CREATE TABLE IF NOT EXISTS chats (
	chatID int NOT NULL AUTO_INCREMENT,
	userID1 char(255) NOT NULL,
	userID2 char(255),
	PRIMARY KEY (chatID)
);

ALTER TABLE chats AUTO_INCREMENT=1001;

CREATE TABLE IF NOT EXISTS users (
	userID int NOT NULL AUTO_INCREMENT,
	userName char(50) NOT NULL,
	PRIMARY KEY (userID)
);

-- ------------------------------------------------------------------------------------------
-- Shopping Cart Tables----------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS carts (
	cartID int NOT NULL AUTO_INCREMENT,
	userID int NOT NULL,
	purchased bool NOT NULL,
	PRIMARY KEY (cartID)
);

ALTER TABLE carts AUTO_INCREMENT=1001;

CREATE TABLE IF NOT EXISTS products (
	itemID int NOT NULL AUTO_INCREMENT,
	itemName char (255) NOT NULL,
	itemDesc char (255) NOT NULL,
	itemPrice DECIMAL(6,2),
	PRIMARY KEY (itemID)
);

ALTER TABLE products AUTO_INCREMENT=1001;

CREATE TABLE IF NOT EXISTS itemCarts (
	instanceID int NOT NULL AUTO_INCREMENT,
	cartID int NOT NULL,
	itemID int NOT NULL,
	qty int NOT NULL,
	PRIMARY KEY (instanceID)
);

ALTER TABLE itemCarts AUTO_INCREMENT=1001;


-- ------------------------------------------------------------------------------------------
-- chat tables add foreign keys--------------------------------------------------------------
-- ------------------------------------------------------------------------------------------


ALTER TABLE messages
ADD FOREIGN KEY (userID) REFERENCES users(userID);

ALTER TABLE messages
ADD FOREIGN KEY (chatID) REFERENCES chats(chatID);

ALTER TABLE chats
ADD FOREIGN KEY (userID1) REFERENCES users(userID);

ALTER TABLE chats
ADD FOREIGN KEY (userID2) REFERENCES users(userID);


-- ------------------------------------------------------------------------------------------
-- shopping cart tables add foreign keys-----------------------------------------------------
-- ------------------------------------------------------------------------------------------


ALTER TABLE carts
ADD FOREIGN KEY (userID) REFERENCES users(userID);

ALTER TABLE itemCarts
ADD FOREIGN KEY (cartID) REFERENCES carts(cartID);

ALTER TABLE itemCarts
ADD FOREIGN KEY (itemID) REFERENCES products(itemID);


-- ------------------------------------------------------------------------------------------
-- populate product data---------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------


INSERT INTO products (itemName, itemDesc, itemPrice)
VALUES ("4x6 Portrait", "One photo portrait at 4x6 size", 4.99);

INSERT INTO products (itemName, itemDesc, itemPrice)
VALUES ("5x8 Portrait", "One photo portrait at 5x8 size", 5.99);

INSERT INTO products (itemName, itemDesc, itemPrice)
VALUES ("8x10 Portrait", "One photo portrait at 8x10 size", 7.99);


-- ------------------------------------------------------------------------------------------
-- Chat procedures---------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------


-- procedure to sanitize data being entered into the database
-- CALL bleach("<stringIN>", @cleanString);
-- SELECT @cleanString;
DELIMITER //
CREATE PROCEDURE bleach (IN stringIN char(255), INOUT cleanString char(255))
BEGIN
	-- make the string lower case for testing
	SET @uncleanString = stringIN;
	SET @uncleanString = LOWER(@uncleanString);

	-- remove = SIGN
	SET @uncleanString = REPLACE(@uncleanString, '=', '!#eq');
	-- remove OR
	SET @uncleanString = REPLACE(@uncleanString, ' or ', ' !#0r ');	
	-- remove AND
	SET @uncleanString = REPLACE(@uncleanString, ' and ', ' !#& ');
	-- remove SELECT
	SET @uncleanString = REPLACE(@uncleanString, ' select ', '!#slct ');
	-- remove DROP
	SET @uncleanString = REPLACE(@uncleanString, ' drop ', ' !#drp ');	
	-- remove INSERT
	SET @uncleanString = REPLACE(@uncleanString, ' insert ', ' !#ins ');	
	-- remove DELETE
	SET @uncleanString = REPLACE(@uncleanString, ' delete ', ' !#del ');	
	-- remove ALTER
	SET @uncleanString = REPLACE(@uncleanString, ' alter ', ' !#alt ');	
	-- remove CREATE
	SET @uncleanString = REPLACE(@uncleanString, ' create ', ' !#cre ');	
	-- remove WHERE
	SET @uncleanString = REPLACE(@uncleanString, ' where ', ' !#whe ');	
	-- remove + SIGN
	SET @uncleanString = REPLACE(@uncleanString, '+', '!#plu');
	-- remove - sign
	SET @uncleanString = REPLACE(@uncleanString, '-', '!#min');	
	-- remove / sign
	SET @uncleanString = REPLACE(@uncleanString, '/', '!#fsl');
	-- remove \ sign
	SET @uncleanString = REPLACE(@uncleanString, '\\', '!#bsl');
	-- remove * sign
	SET @uncleanString = REPLACE(@uncleanString, '*', '!#sta');
	-- remove ( sign
	SET @uncleanString = REPLACE(@uncleanString, '(', '!#lper');	
	-- remove ) sign
	SET @uncleanString = REPLACE(@uncleanString, ')', '!#rper');	
	-- remove ; SIGN
	SET @uncleanString = REPLACE(@uncleanString, ';', '!#scol');	
	SET cleanString = @uncleanString;
END //
DELIMITER ;	

-- procedure to change strings back to readable where needed from bleaching
-- contaminate("<stringIN>");
DELIMITER //
CREATE FUNCTION contaminate (stringIN char(255))
RETURNS char(255)
BEGIN
	-- declare local variables
	DECLARE cleanString char(255);
	DECLARE uncleanString char(255);
	
	-- make the string lower case for testing
	SET cleanString = stringIN;
	SET cleanString = LOWER(cleanString);
	
	-- remove = SIGN
	SET cleanString = REPLACE(cleanString, '!#eq', '=');
	-- remove OR
	SET cleanString = REPLACE(cleanString, ' !#0r ', ' or ');	
	-- remove AND
	SET cleanString = REPLACE(cleanString, ' !#& ', ' and ');
	-- remove SELECT
	SET cleanString = REPLACE(cleanString, '!#slct ', ' select ');
	-- remove DROP
	SET cleanString = REPLACE(cleanString, ' !#drp ', ' drop ');	
	-- remove INSERT
	SET cleanString = REPLACE(cleanString, ' !#ins ', ' insert ');	
	-- remove DELETE
	SET cleanString = REPLACE(cleanString, ' !#del ', ' delete ');	
	-- remove ALTER
	SET cleanString = REPLACE(cleanString,' !#alt ', ' alter ');	
	-- remove CREATE
	SET cleanString = REPLACE(cleanString, ' !#cre ', ' create ');	
	-- remove WHERE
	SET cleanString = REPLACE(cleanString, ' !#whe ', ' where ');	
	-- remove + SIGN
	SET cleanString = REPLACE(cleanString, '!#plu', '+');
	-- remove - sign
	SET cleanString = REPLACE(cleanString, '!#min', '-');	
	-- remove / sign
	SET cleanString = REPLACE(cleanString, '!#fsl', '/');
	-- remove \ sign
	SET cleanString = REPLACE(cleanString, '!#bsl', '\\');
	-- remove * sign
	SET cleanString = REPLACE(cleanString, '!#sta', '*');
	-- remove ( sign
	SET cleanString = REPLACE(cleanString, '!#lper', '(');	
	-- remove ) sign
	SET cleanString = REPLACE(cleanString, '!#rper', ')');	
	-- remove ; SIGN
	SET cleanString = REPLACE(cleanString, '!#scol', ';');	
	SET uncleanString = cleanString;
	RETURN uncleanString;
END //
DELIMITER ;

-- procedure to return all chat messages for current chat, and log into the chat
-- CALL enterChat("<currentChatID>", "<currentUserName>");
DELIMITER //
CREATE PROCEDURE enterChat(IN currentChatID int, IN currentUserName char(50))
BEGIN
	-- log into the chat in chats table
	SET @currentUserID = (SELECT userID FROM users WHERE userName = currentUserName);
	UPDATE chats SET userID2 = (@currentUserID) WHERE chatID = currentChatID;
END //
DELIMITER ;

-- procedure to return the last messages added to the database that have not already been seen by the user
-- CALL lastMessage("<currentChatID>", "<currentUserName>");
-- SELECT * FROM messageFeedUpdate;
DELIMITER //
CREATE PROCEDURE lastMessage(IN currentChatID int, IN currentUser char(255))
BEGIN
	-- get all messages that have not been seen by current user
	DROP TEMPORARY TABLE IF EXISTS messageFeedUpdate;
	
	-- sanitize currentUser
	CALL bleach(currentUser, @cleanString);
	SET @cleanNameIn = (SELECT @cleanString);
	
	-- create local variables
	SET @currentUserID = (SELECT userID FROM users WHERE @cleanNameIn = userName);
	SET @user1Check = (SELECT userID1 FROM chats WHERE ( (@currentUserID = userID1) AND (chatID = currentChatID) ) );
	SET @user2Check = (SELECT userID2 FROM chats WHERE ( (@currentUserID = userID2) AND (chatID = currentChatID) ) );
	
	-- if the current user is userID1 do this
	IF (@user1Check IS NOT NULL) THEN
		CREATE TEMPORARY TABLE messageFeedUpdate 
			SELECT CONCAT(stampDate, " @ ", stampTime, " ", contaminate(userName), ": ", contaminate(message)) as messageFeed
			FROM messages 
			INNER JOIN users ON messages.userID = users.userID
			INNER JOIN chats ON messages.chatID = chats.chatID
			WHERE (
				(messages.chatID = currentChatID) 
				AND 
				(
					(chats.userID1 = @currentUserID) 
					AND 
					(messages.seenByU1 IS NULL)
				)
			);
		
		UPDATE messages
		INNER JOIN chats ON messages.chatID = chats.chatID
		INNER JOIN users ON messages.userID = users.userID
		SET messages.seenByU1 = 'yes'
		WHERE (
				(messages.chatID = currentChatID) 
				AND 
				(@currentUserID = chats.userID1)
			);
	END IF;
	
	-- if the current user is userID2 do this
	IF (@user2Check IS NOT NULL) THEN
		CREATE TEMPORARY TABLE messageFeedUpdate 
			SELECT CONCAT(
				stampDate, " @ ", stampTime, " ", contaminate(userName), ": ", contaminate(message)
				) as messageFeed
			FROM messages 
			INNER JOIN users ON messages.userID = users.userID
			INNER JOIN chats ON messages.chatID = chats.chatID
			WHERE (
				(messages.chatID = currentChatID) 
				AND 
				(
					(chats.userID2 = @currentUserID) 
					AND 
					(messages.seenByU2 IS NULL)
				)
			);
		
		UPDATE messages
		INNER JOIN chats ON messages.chatID = chats.chatID
		INNER JOIN users ON messages.userID = users.userID
		SET messages.seenByU2 = 'yes'
		WHERE (
				(messages.chatID = currentChatID) 
				AND 
				(@currentUserID = chats.userID2)
			);
	END IF;
	
	SELECT * FROM messageFeedUpdate;
END //
DELIMITER ;

-- procedure to insert a message to a chatID
-- CALL newChatMessage("<newMessage>", "<userNameIn>", "<chatID>", "<newDate>", "<newTime>");
DELIMITER //
CREATE PROCEDURE newChatMessage(IN newMessage char(255), IN userNameIn char(50), IN chatID int, IN newDate char(255), IN newTime char(255))
BEGIN	
	-- get the user id for the username entered
	CALL bleach(userNameIn, @cleanString);
	SET @cleanNameIn = (SELECT @cleanString);
	SET @currentUserID = (SELECT userID FROM users WHERE userName = @cleanNameIn);
	
	-- sanitize incoming message
	CALL bleach(newMessage, @cleanMessage);
	
	-- add the message and meta data into the database
	INSERT INTO messages (message, userID, chatID, stampTime, stampDate) VALUES (@cleanMessage, @currentUserID, chatID, newTime, newDate);
END //
DELIMITER ;

-- procedure to check if a user is in the users table, if not then add them.
-- CALL newUser("<userNameIn>");
DELIMITER //
CREATE PROCEDURE newUser(IN userNameIn char(255))
BEGIN
	-- sanitize the new username
	CALL bleach(userNameIn, @cleanString);
	SET @cleanName = (SELECT @cleanString);
	
	-- find out if the username exists
	-- if it does not exist add it to the table
	IF (SELECT userName FROM users WHERE userName = @cleanName) IS NULL then
		INSERT INTO users (userName) VALUES (@cleanName);
	END IF;
END //
DELIMITER ;

-- procedure to get a new chat id from the database
-- CALL newChatID("<userNameIn>", @newChatID);
DELIMITER //
CREATE PROCEDURE newChatID(IN userNameIn char(255), INOUT newChatID int)
BEGIN
	-- get the userID from the users table for username entered
	CALL bleach(userNameIn, @cleanString);
	SET @cleanNameIn = (SELECT @cleanString);
	SET @currentUserID = (SELECT userID FROM users WHERE userName = @cleanNameIn);
	
	-- create a new chat record, select the ID for the new record
	INSERT INTO chats (userID1) VALUES (@currentUserID);
	SET newChatID = (SELECT MAX(chatID) FROM chats WHERE userID1 = @currentUserID);
	
	SELECT MAX(chatID) FROM chats WHERE userID1 = @currentUserID;
END //
DELIMITER ;

-- check to see if there are any user requests for a chat that have not been answered yet
-- CALL checkRequests();
DELIMITER //
CREATE PROCEDURE checkRequests()
BEGIN
	DROP TEMPORARY TABLE IF EXISTS newRequests;
	CREATE TEMPORARY TABLE newRequests
		SELECT CONCAT("Chat request from: ", users.userName, ". ChatID: ", chats.chatID) AS requests FROM users
		INNER JOIN chats ON users.userID = chats.userID1
		WHERE chats.userID2 IS NULL;
	
	SELECT * FROM newRequests;
END //
DELIMITER ;


-- ------------------------------------------------------------------------------------------
-- Shopping Cart procedures------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------


-- pull information about all unordered carts
-- CALL cartStatus();
DELIMITER //
CREATE PROCEDURE cartStatus()
BEGIN
	-- find the total amount for all carts
	DROP TEMPORARY TABLE IF EXISTS cartTotals;
	CREATE TEMPORARY TABLE cartTotals
		SELECT carts.cartID, SUM(products.itemPrice) as totalPrice FROM carts
		INNER JOIN itemCarts ON carts.cartID = itemCarts.cartID
		INNER JOIN products ON itemCarts.itemID = products.itemID
		GROUP BY carts.cartID;
	
	-- create the table showing information about open carts
	DROP TEMPORARY TABLE IF EXISTS openCarts;
	CREATE TEMPORARY TABLE openCarts
		SELECT CONCAT("CartID: ", carts.cartID, " User Name: ", users.userName, " Total Cart Value: ", cartTotals.totalPrice) as openCarts FROM carts
		INNER JOIN users ON carts.userID = users.userID
		INNER JOIN cartTotals ON carts.cartID = cartTotals.cartID
		WHERE carts.purchased = false;
		
	SELECT * FROM openCarts;
END //
DELIMITER ;

-- get all products from the products table
-- CALL getProducts();
DELIMITER //
CREATE PROCEDURE getProducts()
BEGIN	
	SELECT CONCAT(
		itemID, " ", itemName, "<br>",
		"Description: ", itemDesc, "<br>",
		"Price: ", itemPrice		
	) 
	FROM products;
	
END //
DELIMITER ;

-- add an item to a users shopping Cart
-- CALL addtoCart(<itemNum>);
DELIMITER //
CREATE PROCEDURE addtoCart(IN itemNum int, IN currentUser char(255))
BEGIN
	-- get the user id for the username entered
	CALL bleach(currentUser, @cleanString);
	SET @cleanNameIn = (SELECT @cleanString);
	SET @currentUserID = (SELECT userID FROM users WHERE userName = @cleanNameIn);
	
	-- find current cart number
	SET @cartExists = (SELECT cartID FROM carts WHERE ((@currentUserID = userID) AND (purchased = 0)));

	-- find out if there is an unordered cart for user
	IF @cartExists IS NULL THEN
		-- if there are no unpurchsed carts, create a new cart
	 	INSERT INTO carts (userID, purchased) VALUES (@currentUserID, 0);
	END IF;

	-- grab the cart number for the unpurchased cart from this user
	SET @cartNum = (SELECT cartID FROM carts WHERE ((@currentUserID = userID) AND (purchased = 0)));
	
	-- add the item to the itemCarts table
	INSERT INTO itemCarts (cartID, itemID, qty) VALUES (@cartNum, itemNum, '1');
END //
DELIMITER ;

-- grab item list from open shopping Cart
-- CALL getCart(<userName>);
DELIMITER //
CREATE PROCEDURE getCart(IN currentUser char(255))
BEGIN
	-- sanitize the username entered
	CALL bleach(currentUser, @cleanString);
	SET @cleanName = (SELECT @cleanString);
	
	-- find the userID for the current user
	SET @currentUserID = (SELECT userID FROM users WHERE userName = @cleanName);
	
	-- find the cart number for current user
	SET @openCartID = (SELECT cartID from Carts WHERE ((@currentUserID = userID) AND (purchased = 0)));
	
	-- grab the items that are in the users open cart
	DROP TEMPORARY TABLE IF EXISTS itemsInCart;
	CREATE TEMPORARY TABLE itemsInCart
		SELECT CONCAT(
			instanceID, " Item#: ", itemCarts.itemID, " ", products.itemName, "<br>",
			"Description: ", products.itemDesc, "<br>",
			"Price: ", products.itemPrice
		) AS items
		FROM itemCarts
		INNER JOIN products ON itemCarts.itemID = products.itemID
		WHERE cartID = @openCartID;
	
	SELECT * FROM itemsInCart;

END //
DELIMITER ;

-- grab the cart number for the unpurchased cart.
-- CALL getCartNum(<currentUser>);
DELIMITER //
CREATE PROCEDURE getCartNum(IN currentUser char(255))
BEGIN
	-- sanitize the username entered
	CALL bleach(currentUser, @cleanString);
	SET @cleanName = (SELECT @cleanString);
	
	-- find the userID for the current user
	SET @currentUserID = (SELECT userID FROM users WHERE userName = @cleanName);
	
	-- create a new cart if there is not an unpurchased cart
	IF ((SELECT carts.cartID FROM carts
		WHERE ((@currentUserID = carts.userID) AND (carts.purchased = false))) IS NULL) THEN
		-- if there are no unpurchsed carts, create a new cart
		INSERT INTO carts (userID, purchased) VALUES (@currentUserID, false);
	END IF;

	-- select the cartID
	SELECT cartID FROM carts WHERE ((userID = @currentUserID) AND (purchased = false));
	
END //
DELIMITER ;

-- remove an item from a cart
-- CALL removeFromCart(<instanceNum>);
DELIMITER //
CREATE PROCEDURE removeFromCart(IN instanceNum int)
BEGIN
	DELETE FROM itemCarts WHERE instanceID = instanceNum;
END //
DELIMITER ;
-- ------------------------------------------------------------------------------------------
-- SQL test script---------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------

USE chats;
DELETE FROM users;
DELETE FROM chats;
DELETE FROM messages;

-- create users Brandon and Alastrina
CALL newUser("Brandon");
CALL newUser("Alastrina");

-- Brandon requests a chat with a representative
CALL newChatID("Brandon", @newChatID);
SELECT @newChatID;
SET @chatID1 = @newChatID;

-- Brandon asks a couple questions.
CALL newChatMessage("Hi", "Brandon", @chatID1, "12", "12");
CALL newChatMessage("I have a problem.", "Brandon", @chatID1, "13", "13");

-- Alastrina get the notification that a user needs to chat and enters the chat.
CALL enterChat(@chatID1, "Alastrina");

-- Alastrina asks a question
CALL newChatMessage("What can I help with?", "Alastrina", @chatID1, "14", "14");

CALL lastMessage(@chatID1, "Alastrina");
SELECT * FROM messageFeedUpdate;

-- A new user Jasper request a chat with a representative
CALL newUser("Jasper;)");
CALL newChatID("Jasper;)", @newChatID);
SELECT @newChatID;
SET @chatID2 = @newChatID;

-- Jasper asks some questions
CALL newChatMessage("Hello!", "Jasper;)", @chatID2, "15", "15");
CALL newChatMessage("I need help selecting portraits please.", "Jasper;)", @chatID2, "16", "16");

-- Alastrina gets the notification and opens a new window for this chat
CALL enterChat(@chatID2, "Alastrina");
CALL lastMessage(@chatID2, "Alastrina");
SELECT * FROM messageFeedUpdate;

-- Alastrina asks Jasper a question
CALL newChatMessage("hello, I would be glad to help with that and more.", "Alastrina", @chatID2, "17", "17");

-- Jasper checks the screen
CALL lastMessage(@chatID2, "Jasper;)");
SELECT * FROM messageFeedUpdate;

-- Brandon checks the screen
CALL lastMessage(@chatID1, "Brandon");
SELECT * FROM messageFeedUpdate;
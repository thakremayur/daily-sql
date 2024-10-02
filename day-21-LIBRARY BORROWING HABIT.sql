/* 
	PROBLEM STATEMENT(8):
	LIBRARY BORROWING HABITS
Imagine you're working for a library and you're
tasked with generating a report on the borrowing
habits of patrons. You have two tables in your
database: Books and Borrowers.
Write an SQL to display the name of each borrower
along with a comma-separated list of the books they
have borrowed in alphabetical order, display the
output in ascending order of Borrower Name.

*/
CREATE TABLE Borrowers (
    BorrowerID INT,
    BorrowerName VARCHAR(100),
    BookID INT,
    PRIMARY KEY (BorrowerID, BookID)
);
INSERT INTO Borrowers (BorrowerID, BorrowerName, BookID) VALUES
(1, 'Alice', 1),
(2, 'Bob', 2),
(3, 'Charlie', 3),
(4, 'David', 4),
(5, 'Eve', 5),
(6, 'Frank', 6),
(7, 'Grace', 7),
(1, 'Alice', 5),
(2, 'Bob', 6),
(3, 'Charlie', 7),
(4, 'David', 8),
(6, 'Frank', 10),
(8, 'Harry', 2);

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    BookName VARCHAR(255),
    Genre VARCHAR(100)
);

INSERT INTO Books (BookID, BookName, Genre) VALUES
(1, 'The Great Gatsby', 'Fiction'),
(2, 'To Kill a Mockingbird', 'Fiction'),
(3, '1984', 'Fiction'),
(4, 'The Catcher in the Rye', 'Fiction'),
(5, 'Pride and Prejudice', 'Romance'),
(6, 'Romeo and Juliet', 'Romance'),
(7, 'The Notebook', 'Romance'),
(8, 'The Hunger Games', 'Science Fiction'),
(9, 'Dune', 'Science Fiction'),
(10, 'Foundation', 'Science Fiction');

/*
expected output:
-----------------------------------------------------------------
| BORROWERNAME          | RESULT          						|
-----------------------------------------------------------------
| Alice                 | Pride and Prejudice, The Great Gatsby |
| Bob                   | Romeo and Juliet, To Kill a Mockingbird |
| Charlie               | 1984, The Notebook 					|
| David                 | The Catcher in the Rye, The Hunger Games |
| Eve                   | Pride and Prejudice 					|
| Frank                 | Foundation, Romeo and Juliet 			|
| Grace                 | The Notebook     						|
| Harry                 | To Kill a Mockingbird 				|
| Ivy                   | 1984             						|
-----------------------------------------------------------------

*/
USE LibrariesBase; 

--к-во и список доступных книг (всего и по библиотеке) на данный момент
DROP VIEW IF EXISTS dbo.vIssuedBooks;
CREATE VIEW dbo.vIssuedBooks 
  AS SELECT BookTitles.Title, Books.BookTitleID, LibraryID, IsAvailable, Price 
    FROM Books INNER JOIN BookTitles
	  ON Books.BookTitleID = BookTitles.BookTitleID
	WHERE IsAvailable = 1;

SELECT Title, BookTitleID, LibraryID, IsAvailable, Price 
  FROM dbo.vIssuedBooks ;

GO

--автор который не написал ни одну книгу
--INSERT INTO Authors(FirstName, LastName) VALUES('Сара', 'Джио'); 

DROP VIEW IF EXISTS dbo.vAuthorWithoutBook; 

CREATE VIEW dbo.vAuthorWithoutBook
  AS SELECT * 
    FROM Authors 
	WHERE NOT EXISTS(SELECT * FROM BookTitlesAuthors
	               WHERE Authors.AuthorID = BookTitlesAuthors.AuthorID)
  
SELECT * FROM dbo.vAuthorWithoutBook;

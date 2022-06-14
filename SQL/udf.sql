USE LibrariesBase; 

-- найти все факты выдачи-возвращения книг в одной библиотеке 
DROP FUNCTION IF EXISTS dbo.udf_Get_BooksPersons
CREATE FUNCTION dbo.udf_Get_BooksPersons (@LibraryID INT)
RETURNS table 
AS
RETURN 
  SELECT Books.BookID, BooksPersons.BooksPersonID, Libraries.LibraryName 
    FROM BooksPersons INNER JOIN Books
	  ON Books.BookID = BooksPersons.BookID
	    INNER JOIN Libraries
		  ON Libraries.LibraryID = Books.LibraryID
  WHERE Libraries.LibraryID = @LibraryID; 

SELECT * FROM dbo.udf_Get_BooksPersons(3);

--
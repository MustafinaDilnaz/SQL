USE LibrariesBase; 

DROP TABLE IF EXISTS GlobalInfo  
CREATE TABLE GlobalInfo (
  GlobalInfoID INT NOT NULL IDENTITY PRIMARY KEY,
  LibraryID INT NOT NULL UNIQUE,
  BookProvided INT NOT NULL, -- к-во выданных книг за все время
);

DROP PROCEDURE IF EXISTS dbo.sp_Set_BookProvided;

CREATE PROCEDURE dbo.sp_Set_BookProvided 
AS
BEGIN
SET NOCOUNT ON
  DECLARE @LibraryID INT = 1; 
  DECLARE @BookProvided INT; 
  WHILE(@LibraryID < 7)
  BEGIN 
    SET @BookProvided = (SELECT COUNT(Books.BookID) 
	                       FROM BooksPersons INNER JOIN Books
							 ON Books.BookID = BooksPersons.BookID
						   WHERE LibraryID = @LibraryID)
    INSERT INTO GlobalInfo (LibraryID, BookProvided) 
	  VALUES (@LibraryID, @BookProvided); 
  SET @LibraryID += 1; 
  END
END;

EXEC dbo.sp_Set_BookProvided; 

DROP FUNCTION IF EXISTS dbo.udf_Get_BookProvided
CREATE FUNCTION dbo.udf_Get_BookProvided ()
RETURNS table 
AS
RETURN 
  SELECT LibraryID, BookProvided 
    FROM GlobalInfo

SELECT * FROM dbo.udf_Get_BookProvided ();



DROP TRIGGER IF EXISTS tr_GlobalInfo;
GO
CREATE TRIGGER tr_GlobalInfo ON GlobalInfo
  FOR INSERT, UPDATE, DELETE
AS
  SET NOCOUNT ON; 
  SELECT * FROM inserted;
  SELECT * FROM deleted;
  DECLARE @LibraryId INT = SELECT LibraryID FROM inserted
  UPDATE GlobalInfo
    SET BookProvided = (SELECT COUNT(Books.BookID) 
	                       FROM BooksPersons INNER JOIN Books
							 ON Books.BookID = BooksPersons.BookID
							   INNER JOIN inserted

						   WHERE Libraries.LibraryID = Books.LibraryID )
GO  

BEGIN TRANSACTION 
SET NOCOUNT ON;

INSERT INTO GlobalInfo(LibraryID, BookProvided) VALUES (8, 15); 

UPDATE GlobalInfo
  SET BookProvided = 0
  WHERE LibraryID = 1; 

ROLLBACK TRANSACTION; 



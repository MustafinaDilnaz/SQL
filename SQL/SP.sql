USE LibrariesBase; 

DROP INDEX IF EXISTS index1; 
CREATE INDEX index1 ON Books (BookID);


--�-�� � ������ ��������� ���� (����� � �� ����������) �� ������ ������
DROP PROCEDURE IF EXISTS IssuedBooks;

CREATE PROCEDURE IssuedBooks (@LibID INT)
AS
BEGIN
SET NOCOUNT ON
SELECT * 
  FROM dbo.vIssuedBooks
    WHERE LibraryID = @LibID; 
END;

EXEC IssuedBooks 5;


--��������� ��� �� ����������

DROP PROCEDURE IF EXISTS PriceCompare;

CREATE PROCEDURE PriceCompare (@Title CHAR(50))
AS
BEGIN
SET NOCOUNT ON
SELECT Title, Libraries.LibraryName, Price 
  FROM BookTitles INNER JOIN Books
    ON BookTitles.BookTitleID = Books.BookTitleID
	  INNER JOIN Libraries
	    ON Libraries.LibraryID = Books.LibraryID
	WHERE Title = @Title
END;

EXEC PriceCompare '����� ������������';

SELECT * FROM Libraries; 


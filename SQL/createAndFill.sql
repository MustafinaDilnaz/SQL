USE master;
GO
IF EXISTS (SELECT Name FROM sys.databases WHERE name='LibrariesBase')
  ALTER DATABASE LibrariesBase SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE IF EXISTS LibrariesBase;
GO
CREATE DATABASE LibrariesBase;
GO
ALTER DATABASE LibrariesBase SET RECOVERY SIMPLE;
GO

USE LibrariesBase;

DROP TABLE IF EXISTS Cities 
CREATE TABLE Cities (
	CityID BIGINT IDENTITY(1,1) NOT NULL,
	CityName NVARCHAR(20) NOT NULL,
	
	CONSTRAINT PK_Cities PRIMARY KEY (CityID),
	CONSTRAINT UQ_Cities_CityNames UNIQUE (CityName)
);

DROP TABLE IF EXISTS Libraries  
CREATE TABLE Libraries  (
	LibraryID BIGINT IDENTITY(1,1) NOT NULL,
	CityID BIGINT NOT NULL,
	LibraryName NVARCHAR(50) NOT NULL,
	
	CONSTRAINT PK_Libraries PRIMARY KEY (LibraryID),
	CONSTRAINT UQ_Libraries_LibraryNames UNIQUE (LibraryName),
	CONSTRAINT FK_Libraries_To_Cities FOREIGN KEY (CityID) REFERENCES Cities(CityID) ON DELETE CASCADE, 
);

DROP TABLE IF EXISTS Authors   
CREATE TABLE Authors   (
	AuthorID  BIGINT IDENTITY(1,1) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	FirstName NVARCHAR(20) NOT NULL,
	
	CONSTRAINT PK_Authors PRIMARY KEY (AuthorID),
	CONSTRAINT UQ_Authors_Names UNIQUE (LastName, FirstName)
);

DROP TABLE IF EXISTS BookTitles 
CREATE TABLE BookTitles (
	BookTitleID  BIGINT IDENTITY(1,1) NOT NULL,
	Title NVARCHAR(50) NOT NULL,
	
	CONSTRAINT PK_BookTitles PRIMARY KEY (BookTitleID)
);

DROP TABLE IF EXISTS BookTitlesAuthors 
CREATE TABLE BookTitlesAuthors  (
	BookTitlesAuthorID  BIGINT IDENTITY(1,1) NOT NULL, 
	BookTitleID BIGINT NOT NULL,
	AuthorID BIGINT NOT NULL,
	
	CONSTRAINT PK_BookTitlesAuthors PRIMARY KEY (BookTitlesAuthorID), 
	CONSTRAINT FK_BookTitlesAuthors_To_BookTitles FOREIGN KEY (BookTitleID) REFERENCES BookTitles(BookTitleID) ON DELETE CASCADE, 
	CONSTRAINT FK_BookTitlesAuthors_To_Authors FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Books  
CREATE TABLE Books (
	BookID  BIGINT IDENTITY(1,1) NOT NULL, 
	BookTitleID BIGINT NOT NULL,
	LibraryID BIGINT NOT NULL, 
	-- 1 - ����������, 2 - �������, 3 - �������,4 - � ���������
	Status INT NOT NULL,
	-- 1 - ��������, 2 - ������
	IsAvailable BIT NOT NULL, 
	Price MONEY NOT NULL, 
	ReceiptDate DATE NOT NULL, 

	CONSTRAINT PK_Books PRIMARY KEY (BookID), 
	CONSTRAINT FK_Books_To_BookTitles FOREIGN KEY (BookTitleID) REFERENCES BookTitles(BookTitleID) ON DELETE CASCADE, 
	CONSTRAINT FK_Books_To_Libraries FOREIGN KEY (LibraryID) REFERENCES Libraries(LibraryID) ON DELETE CASCADE
);


DROP TABLE IF EXISTS Persons;
CREATE TABLE Persons (
	PersonID BIGINT IDENTITY(1,1) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	FirstName NVARCHAR(20) NOT NULL,
	CONSTRAINT PK_Students PRIMARY KEY (PersonID)
 );

 --BooksPersons (BookPersonID, PersonID, BookID, BeginDate, ReturnDate) - ����� ������-����������� ����.
 DROP TABLE IF EXISTS BooksPersons   
CREATE TABLE BooksPersons  (
	BooksPersonID  BIGINT IDENTITY(1,1) NOT NULL, 
	PersonID BIGINT NOT NULL,
	BookID BIGINT NOT NULL, 
	BeginDate DATE NOT NULL, 
	ReturnDate DATE NOT NULL, 

	CONSTRAINT PK_BooksPersons PRIMARY KEY (BooksPersonID), 
	CONSTRAINT FK_BooksPersons_To_Persons FOREIGN KEY (PersonID) REFERENCES Persons(PersonID) ON DELETE CASCADE, 
	CONSTRAINT FK_BooksPersons_To_Books FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE
);


INSERT INTO Cities (CityName) VALUES ('Astana'); 
INSERT INTO Cities (CityName) VALUES ('New York'); 
INSERT INTO Cities (CityName) VALUES ('Moscow'); 
INSERT INTO Cities (CityName) VALUES ('Tokio'); 


INSERT INTO Libraries(CityID, LibraryName) VALUES (1, 'National Academic Library of the Kazakhstan'); 
INSERT INTO Libraries(CityID, LibraryName) VALUES (1, 'Central City Library. M.O. Auezov'); 
INSERT INTO Libraries(CityID, LibraryName) VALUES (3, 'Russian State Library for Youth'); 
INSERT INTO Libraries(CityID, LibraryName) VALUES (2, 'New York Public Library'); 
INSERT INTO Libraries(CityID, LibraryName) VALUES (4, 'Tokyo Metropolitan Central Library'); 
INSERT INTO Libraries(CityID, LibraryName) VALUES (4, 'University of Tokyo Library'); 


INSERT INTO Authors(LastName, FirstName) VALUES ('������', '���������'); 
INSERT INTO Authors(LastName, FirstName) VALUES ('���������', '����'); 
INSERT INTO Authors(LastName, FirstName) VALUES ('���', '�������'); 
INSERT INTO Authors(LastName, FirstName) VALUES ('��������', '���'); 
INSERT INTO Authors(LastName, FirstName) VALUES ('����', '����'); 
INSERT INTO Authors(LastName, FirstName) VALUES ('Ը���', '�����������'); 


INSERT INTO BookTitles(Title) VALUES ('����� � ���'); 
INSERT INTO BookTitles(Title) VALUES ('����������� �����'); 
INSERT INTO BookTitles(Title) VALUES ('������������ � ���������'); 
INSERT INTO BookTitles(Title) VALUES ('����'); 
INSERT INTO BookTitles(Title) VALUES ('����� ���������'); 
INSERT INTO BookTitles(Title) VALUES ('441 ������ �� ����������'); 
INSERT INTO BookTitles(Title) VALUES ('���� �� �����������'); 
INSERT INTO BookTitles(Title) VALUES ('1984'); 
INSERT INTO BookTitles(Title) VALUES ('������'); 
INSERT INTO BookTitles(Title) VALUES ('�������-���������'); 
INSERT INTO BookTitles(Title) VALUES ('��������������� ��������'); 
INSERT INTO BookTitles(Title) VALUES ('��� ��� �����������'); 
INSERT INTO BookTitles(Title) VALUES ('������� ������'); 
INSERT INTO BookTitles(Title) VALUES ('�������'); 
INSERT INTO BookTitles(Title) VALUES ('��������� �����'); 
INSERT INTO BookTitles(Title) VALUES ('����� ������'); 
INSERT INTO BookTitles(Title) VALUES ('�����-���'); 
INSERT INTO BookTitles(Title) VALUES ('������ � ���������'); 
INSERT INTO BookTitles(Title) VALUES ('����� ������������'); 
INSERT INTO BookTitles(Title) VALUES ('���� ��������'); 
INSERT INTO BookTitles(Title) VALUES ('������'); 



INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (1,3); 
INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (2,21); 
INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (3,20); 
INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (4,19); 
INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (5,18); 
INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (6,17); 
INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (6,16); 
INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (5,15); 
INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (4,14); 
INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (3,13); 
INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (2,12); 
INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (1,11); 
INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (4,10); 
INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (1,9); 
INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (3,8); 
INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (5,7); 
INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (4,6); 
INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (6,5); 
INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (2,4); 
INSERT INTO BookTitlesAuthors(AuthorID,BookTitleID) VALUES (2,2); 




GO
INSERT INTO Books(BookTitleID, LibraryID, Status, IsAvailable, Price, ReceiptDate) 
VALUES (RAND()*(21-1)+1 , RAND()*(7-1)+1, 1, CAST(ROUND(RAND(), 0) AS BIT), RAND()*(25000-1)+1, DATEADD(DAY, (ABS(CHECKSUM(NEWID())) % 65530) , 0)) 
GO 50


INSERT INTO Persons(LastName, FirstName) VALUES ('Mustafina', 'Dilnaz'); 
INSERT INTO Persons(LastName, FirstName) VALUES ('Mustafina', 'Dameli'); 
INSERT INTO Persons(LastName, FirstName) VALUES ('Mustafina', 'Damira'); 
INSERT INTO Persons(LastName, FirstName) VALUES ('Nun', 'Abu'); 
INSERT INTO Persons(LastName, FirstName) VALUES ('Kim', 'Dias'); 
INSERT INTO Persons(LastName, FirstName) VALUES ('Zhanbulat', 'Aruzhan'); 
INSERT INTO Persons(LastName, FirstName) VALUES ('Serikov', 'Ivan'); 
INSERT INTO Persons(LastName, FirstName) VALUES ('Tleuov', 'Akhan'); 
INSERT INTO Persons(LastName, FirstName) VALUES ('Asyl', 'Diana'); 
INSERT INTO Persons(LastName, FirstName) VALUES ('Karashulakova', 'Adelina'); 
INSERT INTO Persons(LastName, FirstName) VALUES ('Karashulakova', 'Aituar'); 


GO
INSERT INTO BooksPersons(PersonID, BookID, BeginDate, ReturnDate)
VALUES (RAND()*(11-1)+1, RAND()*(23-1)+1, 
DATEADD(DAY, (ABS(CHECKSUM(NEWID())) % 65530) , 0), DATEADD(DAY, (ABS(CHECKSUM(NEWID())) % 65530) , 0))
GO 100



USE LibrariesBase; 

GO 
EXEC sp_helpIndex 'Cities'; 
EXEC sp_helpIndex 'Libraries'; 
EXEC sp_helpIndex 'Persons'; 
EXEC sp_helpIndex 'Books'; 

DROP INDEX IF EXISTS index1; 
CREATE INDEX index1 ON Books (BookID);

DROP INDEX IF EXISTS IX_Cities_CityID ON Cities;
CREATE UNIQUE INDEX IX_Cities_CityID ON Cities (CityID);

DROP INDEX IF EXISTS IX_Cities_CityName ON Cities;
CREATE UNIQUE INDEX IX_Cities_CityName ON Cities (CityName);

DROP INDEX IF EXISTS IX_Libraries_LibraryID ON Libraries;
CREATE UNIQUE INDEX IX_Libraries_LibraryID ON Libraries (LibraryID);

DROP INDEX IF EXISTS IX_Libraries_LibraryName ON Libraries;
CREATE UNIQUE INDEX IX_Libraries_LibraryName ON Libraries (LibraryName);

DROP INDEX IF EXISTS IX_Persons_FirstName ON Persons;
CREATE UNIQUE INDEX IX_Persons_FirstName ON Persons (FirstName);


CREATE database DrivingRange;

USE DrivingRange;


CREATE TABLE Customer (
CustomerID INT NOT NULL PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Phone VARCHAR(20),
Email VARCHAR(100)
);

CREATE TABLE [Range] (
RangeID INT NOT NULL PRIMARY KEY,
RangeName VARCHAR(100) NOT NULL,
StreetAddress VARCHAR(100) NOT NULL,
City VARCHAR(50) NOT NULL,
ZipCode VARCHAR(5) NOT NULL,
Target1DistanceYards INT NOT NULL CHECK (Target1DistanceYards > 0),
Target2DistanceYards INT NOT NULL CHECK (Target2DistanceYards > 0),
Target3DistanceYards INT NOT NULL CHECK (Target3DistanceYards > 0)
);

CREATE TABLE TeeBox (
TeeBoxID INT NOT NULL PRIMARY KEY,
RangeID INT NOT NULL FOREIGN KEY REFERENCES [Range](RangeID),
TeeBoxNumber INT NOT NULL,
SurfaceType VARCHAR(5) CHECK (SurfaceType IN ('Grass', 'Turf')),
UNIQUE (RangeID, TeeBoxNumber)
);

CREATE TABLE Tournament (
TournamentID INT NOT NULL PRIMARY KEY,
RangeID INT NOT NULL FOREIGN KEY REFERENCES [Range](RangeID),
TournamentName VARCHAR(100) NOT NULL,
EntryFee DECIMAL(5,2) NOT NULL CHECK (EntryFee >= 0),
StartDate DATE NOT NULL
);

CREATE TABLE BucketOfBalls (
BucketID INT NOT NULL PRIMARY KEY,
BucketSize VARCHAR(1) NOT NULL CHECK (BucketSize IN ('S', 'M', 'L')),
ItemPrice DECIMAL(4,2) NOT NULL CHECK (ItemPrice >= 0)
);

CREATE TABLE TeeBoxUsage (
RentalID INT NOT NULL PRIMARY KEY,
CustomerID INT NOT NULL FOREIGN KEY REFERENCES Customer(CustomerID),
TeeBoxID INT NOT NULL FOREIGN KEY REFERENCES TeeBox(TeeBoxID),
StartTime DATETIME2(0) NOT NULL DEFAULT SYSDATETIME(),
EndTime DATETIME2(0),
CHECK (EndTime IS NULL OR EndTime >= StartTime)
);

CREATE TABLE [Entry] (
EntryID INT NOT NULL PRIMARY KEY,
CustomerID INT NOT NULL FOREIGN KEY REFERENCES Customer(CustomerID),
TournamentID INT NOT NULL FOREIGN KEY REFERENCES Tournament(TournamentID),
RegistrationDate DATE NOT NULL DEFAULT SYSDATETIME(),
Handicap DECIMAL(3,1) NULL,
PaymentStatus BIT NOT NULL,
UNIQUE (TournamentID, CustomerID)
);

CREATE TABLE Purchase (
PurchaseID INT NOT NULL PRIMARY KEY,
CustomerID INT NOT NULL FOREIGN KEY REFERENCES Customer(CustomerID),
BucketID INT NOT NULL FOREIGN KEY REFERENCES BucketOfBalls(BucketID),
PricePaid DECIMAL(6,2) NOT NULL CHECK (PricePaid >= 0),
PurchaseDate DATETIME2(0) NOT NULL DEFAULT SYSDATETIME()
);


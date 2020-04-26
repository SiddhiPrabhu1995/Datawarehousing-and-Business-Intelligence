--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      Chinook_ERtoDimensional.DM1
--
-- Date Created : Thursday, January 30, 2020 11:24:38
-- Target DBMS : MySQL 5.x
--

-- 
-- TABLE: Dim_Album 
--

CREATE TABLE Dim_Album(
    AlbumId_SK    INT                      AUTO_INCREMENT,
    Artist_Id     INT                      NOT NULL,
    AlbumTitle    NATIONAL VARCHAR(160)    NOT NULL,
    ArtistName    NATIONAL VARCHAR(120),
    PRIMARY KEY (AlbumId_SK, Artist_Id)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Customer 
--

CREATE TABLE Dim_Customer(
    CustomerId_SK     INT                     AUTO_INCREMENT,
    Company           NATIONAL VARCHAR(80),
    Fax               VARCHAR(30),
    FirstName         NATIONAL VARCHAR(40)    NOT NULL,
    LastName          NATIONAL VARCHAR(20)    NOT NULL,
    Phone             NATIONAL VARCHAR(24),
    Email             NATIONAL VARCHAR(60)    NOT NULL,
    Type              NATIONAL VARCHAR(60)    NOT NULL,
    GeographyId_SK    INT                     NOT NULL,
    PRIMARY KEY (CustomerId_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Date 
--

CREATE TABLE Dim_Date(
    DateKey    INT            NOT NULL,
    Year       INT,
    Quarter    VARCHAR(10),
    Month      VARCHAR(10),
    Date       DATE,
    Day        VARCHAR(30),
    PRIMARY KEY (DateKey)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Employee 
--

CREATE TABLE Dim_Employee(
    EmployeeId_SK     INT                     AUTO_INCREMENT,
    ReportsTo         INT,
    BirthDate         DATETIME                NOT NULL,
    HireDate          DATETIME,
    Fax               VARCHAR(30),
    FirstName         NATIONAL VARCHAR(40)    NOT NULL,
    LastName          NATIONAL VARCHAR(20)    NOT NULL,
    Phone             NATIONAL VARCHAR(24),
    Email             NATIONAL VARCHAR(60)    NOT NULL,
    Title             NATIONAL VARCHAR(30)    NOT NULL,
    GeographyId_SK    INT                     NOT NULL,
    PRIMARY KEY (EmployeeId_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Geography 
--

CREATE TABLE Dim_Geography(
    GeographyId_SK    INT                     AUTO_INCREMENT,
    Country           NATIONAL VARCHAR(40)    NOT NULL,
    State             NATIONAL VARCHAR(40),
    City              NATIONAL VARCHAR(40),
    PostalCode        NATIONAL VARCHAR(10),
    PRIMARY KEY (GeographyId_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Playlist 
--

CREATE TABLE Dim_Playlist(
    PlaylistId_SK    INT                      AUTO_INCREMENT,
    PlaylistName     NATIONAL VARCHAR(120),
    PRIMARY KEY (PlaylistId_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Track 
--

CREATE TABLE Dim_Track(
    TrackId_SK       INT                      AUTO_INCREMENT,
    PlaylistId_SK    INT                      NOT NULL,
    MediaName        NATIONAL VARCHAR(120),
    GenreName        NATIONAL VARCHAR(120),
    MediaTypeId      INT                      NOT NULL,
    GenreId          INT                      NOT NULL,
    Bytes            INT,
    TrackName        NATIONAL VARCHAR(200)    NOT NULL,
    Composer         NATIONAL VARCHAR(220),
    Millisecond      INT                      NOT NULL,
    AlbumId_SK       INT                      NOT NULL,
    Artist_Id        INT                      NOT NULL,
    PRIMARY KEY (TrackId_SK, PlaylistId_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: FactInvoice 
--

CREATE TABLE FactInvoice(
    InvoiceId_SK      INT                     NOT NULL,
    InvoiceLineId     INT                     NOT NULL,
    DateKey           INT                     NOT NULL,
    BillingAddress    NATIONAL VARCHAR(70),
    UnitPrice         DECIMAL(10, 2)          NOT NULL,
    Quantity          INT                     NOT NULL,
    Total             DECIMAL(10, 2)          NOT NULL,
    TrackId_SK        INT                     NOT NULL,
    PlaylistId_SK     INT                     NOT NULL,
    EmployeeId_SK     INT                     NOT NULL,
    CustomerId_SK     INT                     NOT NULL,
    GeographyId_SK    INT                     NOT NULL,
    PRIMARY KEY (InvoiceId_SK, InvoiceLineId, DateKey)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Customer 
--

ALTER TABLE Dim_Customer ADD CONSTRAINT RefDim_Geography27 
    FOREIGN KEY (GeographyId_SK)
    REFERENCES Dim_Geography(GeographyId_SK)
;


-- 
-- TABLE: Dim_Employee 
--

ALTER TABLE Dim_Employee ADD CONSTRAINT RefDim_Employee24 
    FOREIGN KEY (ReportsTo)
    REFERENCES Dim_Employee(EmployeeId_SK)
;

ALTER TABLE Dim_Employee ADD CONSTRAINT RefDim_Geography26 
    FOREIGN KEY (GeographyId_SK)
    REFERENCES Dim_Geography(GeographyId_SK)
;


-- 
-- TABLE: Dim_Track 
--

ALTER TABLE Dim_Track ADD CONSTRAINT RefDim_Playlist15 
    FOREIGN KEY (PlaylistId_SK)
    REFERENCES Dim_Playlist(PlaylistId_SK)
;

ALTER TABLE Dim_Track ADD CONSTRAINT RefDim_Album16 
    FOREIGN KEY (AlbumId_SK, Artist_Id)
    REFERENCES Dim_Album(AlbumId_SK, Artist_Id)
;


-- 
-- TABLE: FactInvoice 
--

ALTER TABLE FactInvoice ADD CONSTRAINT RefDim_Track4 
    FOREIGN KEY (TrackId_SK, PlaylistId_SK)
    REFERENCES Dim_Track(TrackId_SK, PlaylistId_SK)
;

ALTER TABLE FactInvoice ADD CONSTRAINT RefDim_Date23 
    FOREIGN KEY (DateKey)
    REFERENCES Dim_Date(DateKey)
;

ALTER TABLE FactInvoice ADD CONSTRAINT RefDim_Employee28 
    FOREIGN KEY (EmployeeId_SK)
    REFERENCES Dim_Employee(EmployeeId_SK)
;

ALTER TABLE FactInvoice ADD CONSTRAINT RefDim_Customer29 
    FOREIGN KEY (CustomerId_SK)
    REFERENCES Dim_Customer(CustomerId_SK)
;

ALTER TABLE FactInvoice ADD CONSTRAINT RefDim_Geography30 
    FOREIGN KEY (GeographyId_SK)
    REFERENCES Dim_Geography(GeographyId_SK)
;



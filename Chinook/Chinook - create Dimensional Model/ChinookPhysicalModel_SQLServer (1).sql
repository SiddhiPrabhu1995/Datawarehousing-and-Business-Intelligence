/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      Chinook_ERtoDimensional.DM1
 *
 * Date Created : Thursday, January 30, 2020 11:22:41
 * Target DBMS : Microsoft SQL Server 2017
 */

/* 
 * TABLE: Dim_Album 
 */

CREATE TABLE Dim_Album(
    AlbumId_SK    int              IDENTITY(1,1),
    Artist_Id     int              NOT NULL,
    AlbumTitle    nvarchar(160)    NOT NULL,
    ArtistName    nvarchar(120)    NULL,
    CONSTRAINT PK7 PRIMARY KEY NONCLUSTERED (AlbumId_SK, Artist_Id)
)
go



IF OBJECT_ID('Dim_Album') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Album >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Album >>>'
go

/* 
 * TABLE: Dim_Customer 
 */

CREATE TABLE Dim_Customer(
    CustomerId_SK     int             IDENTITY(1,1),
    Company           nvarchar(80)    NULL,
    Fax               varchar(30)     NULL,
    FirstName         nvarchar(40)    NOT NULL,
    LastName          nvarchar(20)    NOT NULL,
    Phone             nvarchar(24)    NULL,
    Email             nvarchar(60)    NOT NULL,
    Type              nvarchar(60)    NOT NULL,
    GeographyId_SK    int             NOT NULL,
    CONSTRAINT PK5_2 PRIMARY KEY NONCLUSTERED (CustomerId_SK)
)
go



IF OBJECT_ID('Dim_Customer') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Customer >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Customer >>>'
go

/* 
 * TABLE: Dim_Date 
 */

CREATE TABLE Dim_Date(
    DateKey    int            NOT NULL,
    Year       int            NULL,
    Quarter    varchar(10)    NULL,
    Month      varchar(10)    NULL,
    Date       date           NULL,
    Day        varchar(30)    NULL,
    CONSTRAINT PK6 PRIMARY KEY NONCLUSTERED (DateKey)
)
go



IF OBJECT_ID('Dim_Date') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Date >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Date >>>'
go

/* 
 * TABLE: Dim_Employee 
 */

CREATE TABLE Dim_Employee(
    EmployeeId_SK     int             IDENTITY(1,1),
    ReportsTo         int             NULL,
    BirthDate         datetime        NOT NULL,
    HireDate          datetime        NULL,
    Fax               varchar(30)     NULL,
    FirstName         nvarchar(40)    NOT NULL,
    LastName          nvarchar(20)    NOT NULL,
    Phone             nvarchar(24)    NULL,
    Email             nvarchar(60)    NOT NULL,
    Title             nvarchar(30)    NOT NULL,
    GeographyId_SK    int             NOT NULL,
    CONSTRAINT PK5_1 PRIMARY KEY NONCLUSTERED (EmployeeId_SK)
)
go



IF OBJECT_ID('Dim_Employee') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Employee >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Employee >>>'
go

/* 
 * TABLE: Dim_Geography 
 */

CREATE TABLE Dim_Geography(
    GeographyId_SK    int             IDENTITY(1,1),
    Country           nvarchar(40)    NOT NULL,
    State             nvarchar(40)    NULL,
    City              nvarchar(40)    NULL,
    PostalCode        nvarchar(10)    NULL,
    CONSTRAINT PK8 PRIMARY KEY NONCLUSTERED (GeographyId_SK)
)
go



IF OBJECT_ID('Dim_Geography') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Geography >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Geography >>>'
go

/* 
 * TABLE: Dim_Playlist 
 */

CREATE TABLE Dim_Playlist(
    PlaylistId_SK    int              IDENTITY(1,1),
    PlaylistName     nvarchar(120)    NULL,
    CONSTRAINT PK1_1 PRIMARY KEY NONCLUSTERED (PlaylistId_SK)
)
go



IF OBJECT_ID('Dim_Playlist') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Playlist >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Playlist >>>'
go

/* 
 * TABLE: Dim_Track 
 */

CREATE TABLE Dim_Track(
    TrackId_SK       int              IDENTITY(1,1),
    PlaylistId_SK    int              NOT NULL,
    MediaName        nvarchar(120)    NULL,
    GenreName        nvarchar(120)    NULL,
    MediaTypeId      int              NOT NULL,
    GenreId          int              NOT NULL,
    Bytes            int              NULL,
    TrackName        nvarchar(200)    NOT NULL,
    Composer         nvarchar(220)    NULL,
    Millisecond      int              NOT NULL,
    AlbumId_SK       int              NOT NULL,
    Artist_Id        int              NOT NULL,
    CONSTRAINT PK4 PRIMARY KEY NONCLUSTERED (TrackId_SK, PlaylistId_SK)
)
go



IF OBJECT_ID('Dim_Track') IS NOT NULL
    PRINT '<<< CREATED TABLE Dim_Track >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Dim_Track >>>'
go

/* 
 * TABLE: FactInvoice 
 */

CREATE TABLE FactInvoice(
    InvoiceId_SK      int               NOT NULL,
    InvoiceLineId     int               NOT NULL,
    DateKey           int               NOT NULL,
    BillingAddress    nvarchar(70)      NULL,
    UnitPrice         numeric(10, 2)    NOT NULL,
    Quantity          int               NOT NULL,
    Total             numeric(10, 2)    NOT NULL,
    TrackId_SK        int               NOT NULL,
    PlaylistId_SK     int               NOT NULL,
    EmployeeId_SK     int               NOT NULL,
    CustomerId_SK     int               NOT NULL,
    GeographyId_SK    int               NOT NULL,
    CONSTRAINT PK2 PRIMARY KEY NONCLUSTERED (InvoiceId_SK, InvoiceLineId, DateKey)
)
go



IF OBJECT_ID('FactInvoice') IS NOT NULL
    PRINT '<<< CREATED TABLE FactInvoice >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE FactInvoice >>>'
go

/* 
 * TABLE: Dim_Customer 
 */

ALTER TABLE Dim_Customer ADD CONSTRAINT RefDim_Geography27 
    FOREIGN KEY (GeographyId_SK)
    REFERENCES Dim_Geography(GeographyId_SK)
go


/* 
 * TABLE: Dim_Employee 
 */

ALTER TABLE Dim_Employee ADD CONSTRAINT RefDim_Employee24 
    FOREIGN KEY (ReportsTo)
    REFERENCES Dim_Employee(EmployeeId_SK)
go

ALTER TABLE Dim_Employee ADD CONSTRAINT RefDim_Geography26 
    FOREIGN KEY (GeographyId_SK)
    REFERENCES Dim_Geography(GeographyId_SK)
go


/* 
 * TABLE: Dim_Track 
 */

ALTER TABLE Dim_Track ADD CONSTRAINT RefDim_Playlist15 
    FOREIGN KEY (PlaylistId_SK)
    REFERENCES Dim_Playlist(PlaylistId_SK)
go

ALTER TABLE Dim_Track ADD CONSTRAINT RefDim_Album16 
    FOREIGN KEY (AlbumId_SK, Artist_Id)
    REFERENCES Dim_Album(AlbumId_SK, Artist_Id)
go


/* 
 * TABLE: FactInvoice 
 */

ALTER TABLE FactInvoice ADD CONSTRAINT RefDim_Track4 
    FOREIGN KEY (TrackId_SK, PlaylistId_SK)
    REFERENCES Dim_Track(TrackId_SK, PlaylistId_SK)
go

ALTER TABLE FactInvoice ADD CONSTRAINT RefDim_Date23 
    FOREIGN KEY (DateKey)
    REFERENCES Dim_Date(DateKey)
go

ALTER TABLE FactInvoice ADD CONSTRAINT RefDim_Employee28 
    FOREIGN KEY (EmployeeId_SK)
    REFERENCES Dim_Employee(EmployeeId_SK)
go

ALTER TABLE FactInvoice ADD CONSTRAINT RefDim_Customer29 
    FOREIGN KEY (CustomerId_SK)
    REFERENCES Dim_Customer(CustomerId_SK)
go

ALTER TABLE FactInvoice ADD CONSTRAINT RefDim_Geography30 
    FOREIGN KEY (GeographyId_SK)
    REFERENCES Dim_Geography(GeographyId_SK)
go



--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      PurchasingAssignmentWeek2.DM1
--
-- Date Created : Thursday, February 06, 2020 14:35:05
-- Target DBMS : MySQL 5.x
--

-- 
-- TABLE: DimDate 
--

CREATE TABLE DimDate(
    DateKey_SK           DATETIME                NOT NULL,
    DateKey_PK           INT                     NOT NULL,
    DayNumberOfWeek      TINYINT                 NOT NULL,
    DayNumberOfMonth     TINYINT                 NOT NULL,
    DayNumberOfYear      SMALLINT                NOT NULL,
    WeekNumberOfYear     TINYINT                 NOT NULL,
    MonthName            NATIONAL VARCHAR(10)    NOT NULL,
    MonthNumberOfYear    TINYINT                 NOT NULL,
    CalenderYear         TINYINT                 NOT NULL,
    CalenderQuarter      TINYINT                 NOT NULL,
    CalenderSemester     TINYINT                 NOT NULL,
    FiscalQuarter        TINYINT                 NOT NULL,
    FiscalYear           TINYINT                 NOT NULL,
    FiscalSemester       TINYINT                 NOT NULL,
    PRIMARY KEY (DateKey_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimEmployee 
--

CREATE TABLE DimEmployee(
    EmployeeID_SK        INT                     AUTO_INCREMENT,
    EmployeeID_PK        INT                     NOT NULL,
    CurrentFlag          BINARY(1)               NOT NULL,
    NationalIDNumber     NATIONAL VARCHAR(15)    NOT NULL,
    LoginID              NATIONAL VARCHAR(25)    NOT NULL,
    OrganizationNode     CHAR(10)                NOT NULL,
    OrganizationLevel    NATIONAL VARCHAR(10)    NOT NULL,
    JobTitle             NATIONAL VARCHAR(50)    NOT NULL,
    MaritalStatus        BINARY(1)               NOT NULL,
    Gender               NATIONAL CHAR(1)        NOT NULL,
    SalariedFlag         BINARY(1)               NOT NULL,
    VacationHours        SMALLINT                NOT NULL,
    SickLevelHours       SMALLINT                NOT NULL,
    rowguid              BINARY(16)              NOT NULL,
    GeographyID_SK       INT,
    BirthDate            DATETIME,
    DateKey_SK           DATETIME                NOT NULL,
    PRIMARY KEY (EmployeeID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimEmployeePay 
--

CREATE TABLE DimEmployeePay(
    RateChangeDate_Table_SK    DATETIME          NOT NULL,
    RateChgeDateDurable_SK     DATETIME          NOT NULL,
    RateChngeDateDurable_NK    DATETIME          NOT NULL,
    `Current Indicator`        BINARY(1)         NOT NULL,
    RateChangeDate_PK          DATETIME          NOT NULL,
    Rate                       DECIMAL(19, 2)    NOT NULL,
    PayFrequency               TINYINT           NOT NULL,
    EmployeeID_SK              INT,
    EffectiveDate              DATETIME,
    IneffectiveDate            DATETIME,
    ModifiedDate               DATETIME,
    PRIMARY KEY (RateChangeDate_Table_SK, RateChgeDateDurable_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimGeography 
--

CREATE TABLE DimGeography(
    GeographyID_SK    INT                     AUTO_INCREMENT,
    GeographyID_PK    INT                     NOT NULL,
    Country           NATIONAL VARCHAR(20)    NOT NULL,
    State             NATIONAL VARCHAR(30)    NOT NULL,
    City              NATIONAL VARCHAR(30)    NOT NULL,
    ZipCode           NATIONAL VARCHAR(30)    NOT NULL,
    Address           NATIONAL VARCHAR(30)    NOT NULL,
    PRIMARY KEY (GeographyID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimProduct 
--

CREATE TABLE DimProduct(
    ProductID_SK                   INT                     AUTO_INCREMENT,
    Weight                         DECIMAL(8, 2)           NOT NULL,
    Size                           NATIONAL VARCHAR(5)     NOT NULL,
    ProductNumber                  NATIONAL VARCHAR(25)    NOT NULL,
    Name                           NATIONAL VARCHAR(50)    NOT NULL,
    ProductID_PK                   INT                     NOT NULL,
    ShipMethodID_SK                INT,
    ProductModelID_SK              INT,
    ProdCosHisStrDateDurable_SK    DATETIME,
    ProductCategoryID_SK           INT,
    ProductSubCategoryID_SK        INT,
    ProdCostHistStrDateTable_SK    DATETIME,
    ModifiedDate                   DATETIME,
    rowguid                        BINARY(16)              NOT NULL,
    PRIMARY KEY (ProductID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimProductCategory 
--

CREATE TABLE DimProductCategory(
    ProductCategoryID_SK    INT                     AUTO_INCREMENT,
    rowguid                 BINARY(16)              NOT NULL,
    Name                    NATIONAL VARCHAR(50)    NOT NULL,
    ProductCategoryID_PK    INT                     NOT NULL,
    PRIMARY KEY (ProductCategoryID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimProductInventory 
--

CREATE TABLE DimProductInventory(
    LocationID      INT                     NOT NULL,
    ProductID_SK    INT                     NOT NULL,
    Quantity        SMALLINT                NOT NULL,
    Shelf           NATIONAL VARCHAR(10)    NOT NULL,
    rowguid         BINARY(16)              NOT NULL,
    Bin             TINYINT                 NOT NULL,
    ModifiedDate    DATETIME                NOT NULL,
    PRIMARY KEY (LocationID, ProductID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimProductListPrice 
--

CREATE TABLE DimProductListPrice(
    ProdLisPrceStrDateTbl_SK         DATETIME          NOT NULL,
    ProdLisStrDateDurable_SK         DATETIME          NOT NULL,
    ProductListPriceStartDate_NK     DATETIME          NOT NULL,
    CurrentIndicator                 BINARY(1)         NOT NULL,
    ListPrice                        DECIMAL(19, 2)    NOT NULL,
    ProductListPriceID_Durable_SK    DATETIME          NOT NULL,
    IneffectiveDate                  DATETIME,
    EffectiveDate                    DATETIME,
    ModifiedDate                     DATETIME,
    EndDate                          DATETIME          NOT NULL,
    PRIMARY KEY (ProdLisPrceStrDateTbl_SK, ProdLisStrDateDurable_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimProductModel 
--

CREATE TABLE DimProductModel(
    ProductModelID_SK     INT                     AUTO_INCREMENT,
    rowguid               BINARY(16)              NOT NULL,
    Instructions          LONGBLOB                NOT NULL,
    CatalogDescription    LONGBLOB                NOT NULL,
    Name                  NATIONAL VARCHAR(50),
    ProductModel_PK       INT                     NOT NULL,
    PRIMARY KEY (ProductModelID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimProductStandardCost 
--

CREATE TABLE DimProductStandardCost(
    ProdCosHisStrDateDurable_SK       DATETIME          NOT NULL,
    ProdCosHisStrDateTable_SK         DATETIME          NOT NULL,
    CurrentIndicator                  BINARY(1)         NOT NULL,
    CostPrice                         DECIMAL(19, 2)    NOT NULL,
    ProductCostHistoryStartDate_NK    DATETIME          NOT NULL,
    IneffectiveDate                   DATETIME,
    EffectiveDate                     DATETIME,
    ModifiedDate                      DATETIME,
    EndDate                           DATETIME,
    PRIMARY KEY (ProdCosHisStrDateDurable_SK, ProdCosHisStrDateTable_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimProductSubCategory 
--

CREATE TABLE DimProductSubCategory(
    ProductSubCategoryID_SK    INT                     AUTO_INCREMENT,
    ProductSubCategoryID_PK    CHAR(10)                NOT NULL,
    rowguid                    BINARY(16)              NOT NULL,
    Name                       NATIONAL VARCHAR(50)    NOT NULL,
    ModifiedDate               DATETIME,
    PRIMARY KEY (ProductSubCategoryID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimProductVendor 
--

CREATE TABLE DimProductVendor(
    ProductVendor_ProductID_SK    INT               AUTO_INCREMENT,
    ProductVendor_ProductID_PK    INT               NOT NULL,
    AverageLoadTime               INT               NOT NULL,
    StandardPrice                 DECIMAL(19, 2)    NOT NULL,
    MinOrderqty                   INT               NOT NULL,
    MaxOrderQty                   INT               NOT NULL,
    OnOrderQty                    INT               NOT NULL,
    ProductOrderDetailID          INT,
    LastReceiptDate               DATETIME,
    DateKey_SK                    DATETIME          NOT NULL,
    PRIMARY KEY (ProductVendor_ProductID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimSalesTerritory 
--

CREATE TABLE DimSalesTerritory(
    TerritoryID_SK    INT                     NOT NULL,
    TerritoryID_PK    INT                     NOT NULL,
    rowguid           BINARY(16)              NOT NULL,
    CostLastYear      DECIMAL(19, 2)          NOT NULL,
    CostYTD           DECIMAL(19, 2)          NOT NULL,
    SalesLastYear     DECIMAL(19, 2)          NOT NULL,
    SalesYTD          DECIMAL(19, 2)          NOT NULL,
    Group             NATIONAL VARCHAR(50)    NOT NULL,
    Name              NATIONAL VARCHAR(50)    NOT NULL,
    PRIMARY KEY (TerritoryID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimShipMethod 
--

CREATE TABLE DimShipMethod(
    ShipMethodID_SK    INT                     AUTO_INCREMENT,
    rowguid            BINARY(16)              NOT NULL,
    ShipRate           DECIMAL(19, 2)          NOT NULL,
    ShipBase           DECIMAL(19, 2)          NOT NULL,
    Name               NATIONAL VARCHAR(50)    NOT NULL,
    ShipMethodID_PK    INT                     NOT NULL,
    PRIMARY KEY (ShipMethodID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimVendor 
--

CREATE TABLE DimVendor(
    VendorID_SK                INT                       AUTO_INCREMENT,
    VendorID_PK                INT                       NOT NULL,
    PrefferedVendorStatus      BINARY(1)                 NOT NULL,
    ActiveFlag                 BINARY(1)                 NOT NULL,
    PurchasingWebServiceURL    NATIONAL VARCHAR(1024)    NOT NULL,
    AccountNumber              NATIONAL VARCHAR(15)      NOT NULL,
    Name                       NATIONAL VARCHAR(50)      NOT NULL,
    CreditRating               TINYINT                   NOT NULL,
    GeographyID_SK             INT,
    DateKey_SK                 DATETIME                  NOT NULL,
    PRIMARY KEY (VendorID_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: FactOrderDetail 
--

CREATE TABLE FactOrderDetail(
    ProductOrderDetailID    INT               AUTO_INCREMENT,
    StockedQty              DECIMAL(8, 2)     NOT NULL,
    OrderQty                SMALLINT          NOT NULL,
    UnitPrice               DECIMAL(19, 2)    NOT NULL,
    LineTotal               DECIMAL(19, 2)    NOT NULL,
    RejectedQty             DECIMAL(8, 2)     NOT NULL,
    RecievedQty             DECIMAL(8, 2)     NOT NULL,
    PurchaseOrderID         INT,
    ModifiedDate            DATETIME,
    DueDate                 DATETIME,
    ProductID_SK            INT,
    PRIMARY KEY (ProductOrderDetailID)
)ENGINE=MYISAM
;



-- 
-- TABLE: FactPurchaseOrderHeader 
--

CREATE TABLE FactPurchaseOrderHeader(
    PurchaseOrderID               INT               AUTO_INCREMENT,
    RevisionNumber                TINYINT           NOT NULL,
    Status                        TINYINT           NOT NULL,
    TaxAmt                        DECIMAL(19, 2)    NOT NULL,
    SubTotal                      DECIMAL(19, 2)    NOT NULL,
    TotalDue                      DECIMAL(19, 2)    NOT NULL,
    Freight                       DECIMAL(19, 2)    NOT NULL,
    EmployeeID_SK                 INT,
    VendorID_SK                   INT,
    ProductVendor_ProductID_SK    INT,
    ShipMethodID_SK               INT,
    GeographyID_SK                INT,
    ModifiedDate                  DATETIME,
    ShipDate                      DATETIME,
    OrderDate                     DATETIME,
    PRIMARY KEY (PurchaseOrderID)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimEmployee 
--

ALTER TABLE DimEmployee ADD CONSTRAINT RefDimGeography29 
    FOREIGN KEY (GeographyID_SK)
    REFERENCES DimGeography(GeographyID_SK)
;

ALTER TABLE DimEmployee ADD CONSTRAINT RefDimDate45 
    FOREIGN KEY (BirthDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimEmployee ADD CONSTRAINT RefDimDate80 
    FOREIGN KEY (DateKey_SK)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: DimEmployeePay 
--

ALTER TABLE DimEmployeePay ADD CONSTRAINT RefDimEmployee12 
    FOREIGN KEY (EmployeeID_SK)
    REFERENCES DimEmployee(EmployeeID_SK)
;

ALTER TABLE DimEmployeePay ADD CONSTRAINT RefDimDate56 
    FOREIGN KEY (EffectiveDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimEmployeePay ADD CONSTRAINT RefDimDate57 
    FOREIGN KEY (EffectiveDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimEmployeePay ADD CONSTRAINT RefDimDate58 
    FOREIGN KEY (IneffectiveDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimEmployeePay ADD CONSTRAINT RefDimDate64 
    FOREIGN KEY (RateChgeDateDurable_SK)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimEmployeePay ADD CONSTRAINT RefDimDate79 
    FOREIGN KEY (ModifiedDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: DimProduct 
--

ALTER TABLE DimProduct ADD CONSTRAINT RefDimShipMethod24 
    FOREIGN KEY (ShipMethodID_SK)
    REFERENCES DimShipMethod(ShipMethodID_SK)
;

ALTER TABLE DimProduct ADD CONSTRAINT RefDimProductSubCategory35 
    FOREIGN KEY (ProductSubCategoryID_SK)
    REFERENCES DimProductSubCategory(ProductSubCategoryID_SK)
;

ALTER TABLE DimProduct ADD CONSTRAINT RefDimProductModel36 
    FOREIGN KEY (ProductModelID_SK)
    REFERENCES DimProductModel(ProductModelID_SK)
;

ALTER TABLE DimProduct ADD CONSTRAINT RefDimDate37 
    FOREIGN KEY (ModifiedDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProduct ADD CONSTRAINT RefDimProductStandardCost38 
    FOREIGN KEY (ProdCosHisStrDateDurable_SK, ProdCostHistStrDateTable_SK)
    REFERENCES DimProductStandardCost(ProdCosHisStrDateDurable_SK, ProdCosHisStrDateTable_SK)
;

ALTER TABLE DimProduct ADD CONSTRAINT RefDimProductCategory39 
    FOREIGN KEY (ProductCategoryID_SK)
    REFERENCES DimProductCategory(ProductCategoryID_SK)
;


-- 
-- TABLE: DimProductInventory 
--

ALTER TABLE DimProductInventory ADD CONSTRAINT RefDimProduct75 
    FOREIGN KEY (ProductID_SK)
    REFERENCES DimProduct(ProductID_SK)
;

ALTER TABLE DimProductInventory ADD CONSTRAINT RefDimGeography76 
    FOREIGN KEY (LocationID)
    REFERENCES DimGeography(GeographyID_SK)
;

ALTER TABLE DimProductInventory ADD CONSTRAINT RefDimDate87 
    FOREIGN KEY (ModifiedDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: DimProductListPrice 
--

ALTER TABLE DimProductListPrice ADD CONSTRAINT RefDimDate49 
    FOREIGN KEY (ProdLisStrDateDurable_SK)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProductListPrice ADD CONSTRAINT RefDimDate59 
    FOREIGN KEY (IneffectiveDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProductListPrice ADD CONSTRAINT RefDimDate61 
    FOREIGN KEY (EffectiveDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProductListPrice ADD CONSTRAINT RefDimDate78 
    FOREIGN KEY (ModifiedDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProductListPrice ADD CONSTRAINT RefDimDate85 
    FOREIGN KEY (EndDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: DimProductStandardCost 
--

ALTER TABLE DimProductStandardCost ADD CONSTRAINT RefDimDate50 
    FOREIGN KEY (ProdCosHisStrDateTable_SK)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProductStandardCost ADD CONSTRAINT RefDimDate60 
    FOREIGN KEY (IneffectiveDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProductStandardCost ADD CONSTRAINT RefDimDate63 
    FOREIGN KEY (EffectiveDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProductStandardCost ADD CONSTRAINT RefDimDate82 
    FOREIGN KEY (ModifiedDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProductStandardCost ADD CONSTRAINT RefDimDate83 
    FOREIGN KEY (EndDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: DimProductSubCategory 
--

ALTER TABLE DimProductSubCategory ADD CONSTRAINT RefDimDate44 
    FOREIGN KEY (ModifiedDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: DimProductVendor 
--

ALTER TABLE DimProductVendor ADD CONSTRAINT RefFactOrderDetail13 
    FOREIGN KEY (ProductOrderDetailID)
    REFERENCES FactOrderDetail(ProductOrderDetailID)
;

ALTER TABLE DimProductVendor ADD CONSTRAINT RefDimDate48 
    FOREIGN KEY (LastReceiptDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProductVendor ADD CONSTRAINT RefDimDate77 
    FOREIGN KEY (DateKey_SK)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: DimSalesTerritory 
--

ALTER TABLE DimSalesTerritory ADD CONSTRAINT RefDimGeography19 
    FOREIGN KEY (TerritoryID_SK)
    REFERENCES DimGeography(GeographyID_SK)
;


-- 
-- TABLE: DimVendor 
--

ALTER TABLE DimVendor ADD CONSTRAINT RefDimGeography31 
    FOREIGN KEY (GeographyID_SK)
    REFERENCES DimGeography(GeographyID_SK)
;

ALTER TABLE DimVendor ADD CONSTRAINT RefDimDate81 
    FOREIGN KEY (DateKey_SK)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: FactOrderDetail 
--

ALTER TABLE FactOrderDetail ADD CONSTRAINT RefFactPurchaseOrderHeader15 
    FOREIGN KEY (PurchaseOrderID)
    REFERENCES FactPurchaseOrderHeader(PurchaseOrderID)
;

ALTER TABLE FactOrderDetail ADD CONSTRAINT RefDimDate28 
    FOREIGN KEY (ModifiedDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactOrderDetail ADD CONSTRAINT RefDimProduct34 
    FOREIGN KEY (ProductID_SK)
    REFERENCES DimProduct(ProductID_SK)
;

ALTER TABLE FactOrderDetail ADD CONSTRAINT RefDimDate55 
    FOREIGN KEY (DueDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: FactPurchaseOrderHeader 
--

ALTER TABLE FactPurchaseOrderHeader ADD CONSTRAINT RefDimEmployee18 
    FOREIGN KEY (EmployeeID_SK)
    REFERENCES DimEmployee(EmployeeID_SK)
;

ALTER TABLE FactPurchaseOrderHeader ADD CONSTRAINT RefDimVendor25 
    FOREIGN KEY (VendorID_SK)
    REFERENCES DimVendor(VendorID_SK)
;

ALTER TABLE FactPurchaseOrderHeader ADD CONSTRAINT RefDimProductVendor26 
    FOREIGN KEY (ProductVendor_ProductID_SK)
    REFERENCES DimProductVendor(ProductVendor_ProductID_SK)
;

ALTER TABLE FactPurchaseOrderHeader ADD CONSTRAINT RefDimShipMethod32 
    FOREIGN KEY (ShipMethodID_SK)
    REFERENCES DimShipMethod(ShipMethodID_SK)
;

ALTER TABLE FactPurchaseOrderHeader ADD CONSTRAINT RefDimGeography33 
    FOREIGN KEY (GeographyID_SK)
    REFERENCES DimGeography(GeographyID_SK)
;

ALTER TABLE FactPurchaseOrderHeader ADD CONSTRAINT RefDimDate43 
    FOREIGN KEY (ModifiedDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactPurchaseOrderHeader ADD CONSTRAINT RefDimDate52 
    FOREIGN KEY (ShipDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactPurchaseOrderHeader ADD CONSTRAINT RefDimDate53 
    FOREIGN KEY (ShipDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactPurchaseOrderHeader ADD CONSTRAINT RefDimDate54 
    FOREIGN KEY (OrderDate)
    REFERENCES DimDate(DateKey_SK)
;



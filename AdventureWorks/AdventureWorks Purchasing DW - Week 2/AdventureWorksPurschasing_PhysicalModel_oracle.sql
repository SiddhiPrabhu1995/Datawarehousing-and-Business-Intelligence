--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      PurchasingAssignmentWeek2.DM1
--
-- Date Created : Thursday, February 06, 2020 14:31:15
-- Target DBMS : Oracle 11g
--

-- 
-- TABLE: DimDate 
--

CREATE TABLE DimDate(
    DateKey_SK           TIMESTAMP(6)     NOT NULL,
    DateKey_PK           NUMBER(38, 0)    NOT NULL,
    DayNumberOfWeek      NUMBER(3, 0)     NOT NULL,
    DayNumberOfMonth     NUMBER(3, 0)     NOT NULL,
    DayNumberOfYear      SMALLINT         NOT NULL,
    WeekNumberOfYear     NUMBER(3, 0)     NOT NULL,
    MonthName            NVARCHAR2(10)    NOT NULL,
    MonthNumberOfYear    NUMBER(3, 0)     NOT NULL,
    CalenderYear         NUMBER(3, 0)     NOT NULL,
    CalenderQuarter      NUMBER(3, 0)     NOT NULL,
    CalenderSemester     NUMBER(3, 0)     NOT NULL,
    FiscalQuarter        NUMBER(3, 0)     NOT NULL,
    FiscalYear           NUMBER(3, 0)     NOT NULL,
    FiscalSemester       NUMBER(3, 0)     NOT NULL,
    CONSTRAINT PK8 PRIMARY KEY (DateKey_SK)
)
;



-- 
-- TABLE: DimEmployee 
--

CREATE TABLE DimEmployee(
    EmployeeID_SK        NUMBER(38, 0)    NOT NULL,
    EmployeeID_PK        NUMBER(38, 0)    NOT NULL,
    CurrentFlag          RAW(1)           NOT NULL,
    NationalIDNumber     NVARCHAR2(15)    NOT NULL,
    LoginID              NVARCHAR2(25)    NOT NULL,
    OrganizationNode     CHAR(10)         NOT NULL,
    OrganizationLevel    NVARCHAR2(10)    NOT NULL,
    JobTitle             NVARCHAR2(50)    NOT NULL,
    MaritalStatus        RAW(1)           NOT NULL,
    Gender               NCHAR(1)         NOT NULL,
    SalariedFlag         RAW(1)           NOT NULL,
    VacationHours        SMALLINT         NOT NULL,
    SickLevelHours       SMALLINT         NOT NULL,
    rowguid              RAW(16)          NOT NULL,
    GeographyID_SK       NUMBER(38, 0),
    BirthDate            TIMESTAMP(6),
    DateKey_SK           TIMESTAMP(6)     NOT NULL,
    CONSTRAINT PK1_2 PRIMARY KEY (EmployeeID_SK)
)
;



-- 
-- TABLE: DimEmployeePay 
--

CREATE TABLE DimEmployeePay(
    RateChangeDate_Table_SK    TIMESTAMP(6)     NOT NULL,
    RateChgeDateDurable_SK     TIMESTAMP(6)     NOT NULL,
    RateChngeDateDurable_NK    TIMESTAMP(6)     NOT NULL,
    "Current Indicator"        RAW(1)           NOT NULL,
    RateChangeDate_PK          TIMESTAMP(6)     NOT NULL,
    Rate                       NUMBER(19, 2)    NOT NULL,
    PayFrequency               NUMBER(3, 0)     NOT NULL,
    EmployeeID_SK              NUMBER(38, 0),
    EffectiveDate              TIMESTAMP(6),
    IneffectiveDate            TIMESTAMP(6),
    ModifiedDate               TIMESTAMP(6),
    CONSTRAINT PK2 PRIMARY KEY (RateChangeDate_Table_SK, RateChgeDateDurable_SK)
)
;



-- 
-- TABLE: DimGeography 
--

CREATE TABLE DimGeography(
    GeographyID_SK    NUMBER(38, 0)    NOT NULL,
    GeographyID_PK    NUMBER(38, 0)    NOT NULL,
    Country           NVARCHAR2(20)    NOT NULL,
    State             NVARCHAR2(30)    NOT NULL,
    City              NVARCHAR2(30)    NOT NULL,
    ZipCode           NVARCHAR2(30)    NOT NULL,
    Address           NVARCHAR2(30)    NOT NULL,
    CONSTRAINT PK7 PRIMARY KEY (GeographyID_SK)
)
;



-- 
-- TABLE: DimProduct 
--

CREATE TABLE DimProduct(
    ProductID_SK                   NUMBER(38, 0)    NOT NULL,
    Weight                         NUMBER(8, 2)     NOT NULL,
    Size                           NVARCHAR2(5)     NOT NULL,
    ProductNumber                  NVARCHAR2(25)    NOT NULL,
    Name                           NVARCHAR2(50)    NOT NULL,
    ProductID_PK                   NUMBER(38, 0)    NOT NULL,
    ShipMethodID_SK                NUMBER(38, 0),
    ProductModelID_SK              NUMBER(38, 0),
    ProdCosHisStrDateDurable_SK    TIMESTAMP(6),
    ProductCategoryID_SK           NUMBER(38, 0),
    ProductSubCategoryID_SK        NUMBER(38, 0),
    ProdCostHistStrDateTable_SK    TIMESTAMP(6),
    ModifiedDate                   TIMESTAMP(6),
    rowguid                        RAW(16)          NOT NULL,
    CONSTRAINT PK1 PRIMARY KEY (ProductID_SK)
)
;



-- 
-- TABLE: DimProductCategory 
--

CREATE TABLE DimProductCategory(
    ProductCategoryID_SK    NUMBER(38, 0)    NOT NULL,
    rowguid                 RAW(16)          NOT NULL,
    Name                    NVARCHAR2(50)    NOT NULL,
    ProductCategoryID_PK    NUMBER(38, 0)    NOT NULL,
    CONSTRAINT PK1_1_2 PRIMARY KEY (ProductCategoryID_SK)
)
;



-- 
-- TABLE: DimProductInventory 
--

CREATE TABLE DimProductInventory(
    LocationID      NUMBER(38, 0)    NOT NULL,
    ProductID_SK    NUMBER(38, 0)    NOT NULL,
    Quantity        SMALLINT         NOT NULL,
    Shelf           NVARCHAR2(10)    NOT NULL,
    rowguid         RAW(16)          NOT NULL,
    Bin             NUMBER(3, 0)     NOT NULL,
    ModifiedDate    TIMESTAMP(6)     NOT NULL,
    CONSTRAINT PK1_1_2_1 PRIMARY KEY (LocationID, ProductID_SK)
)
;



-- 
-- TABLE: DimProductListPrice 
--

CREATE TABLE DimProductListPrice(
    ProdLisPrceStrDateTbl_SK         TIMESTAMP(6)     NOT NULL,
    ProdLisStrDateDurable_SK         TIMESTAMP(6)     NOT NULL,
    ProductListPriceStartDate_NK     TIMESTAMP(6)     NOT NULL,
    CurrentIndicator                 RAW(1)           NOT NULL,
    ListPrice                        NUMBER(19, 2)    NOT NULL,
    ProductListPriceID_Durable_SK    TIMESTAMP(6)     NOT NULL,
    IneffectiveDate                  TIMESTAMP(6),
    EffectiveDate                    TIMESTAMP(6),
    ModifiedDate                     TIMESTAMP(6),
    EndDate                          TIMESTAMP(6)     NOT NULL,
    CONSTRAINT PK4 PRIMARY KEY (ProdLisPrceStrDateTbl_SK, ProdLisStrDateDurable_SK)
)
;



-- 
-- TABLE: DimProductModel 
--

CREATE TABLE DimProductModel(
    ProductModelID_SK     NUMBER(38, 0)    NOT NULL,
    rowguid               RAW(16)          NOT NULL,
    Instructions          SYS.XMLType      NOT NULL,
    CatalogDescription    SYS.XMLType      NOT NULL,
    Name                  NVARCHAR2(50),
    ProductModel_PK       NUMBER(38, 0)    NOT NULL,
    CONSTRAINT PK1_1_1 PRIMARY KEY (ProductModelID_SK)
)
;



-- 
-- TABLE: DimProductStandardCost 
--

CREATE TABLE DimProductStandardCost(
    ProdCosHisStrDateDurable_SK       TIMESTAMP(6)     NOT NULL,
    ProdCosHisStrDateTable_SK         TIMESTAMP(6)     NOT NULL,
    CurrentIndicator                  RAW(1)           NOT NULL,
    CostPrice                         NUMBER(19, 2)    NOT NULL,
    ProductCostHistoryStartDate_NK    TIMESTAMP(6)     NOT NULL,
    IneffectiveDate                   TIMESTAMP(6),
    EffectiveDate                     TIMESTAMP(6),
    ModifiedDate                      TIMESTAMP(6),
    EndDate                           TIMESTAMP(6),
    CONSTRAINT PK13 PRIMARY KEY (ProdCosHisStrDateDurable_SK, ProdCosHisStrDateTable_SK)
)
;



-- 
-- TABLE: DimProductSubCategory 
--

CREATE TABLE DimProductSubCategory(
    ProductSubCategoryID_SK    NUMBER(38, 0)    NOT NULL,
    ProductSubCategoryID_PK    CHAR(10)         NOT NULL,
    rowguid                    RAW(16)          NOT NULL,
    Name                       NVARCHAR2(50)    NOT NULL,
    ModifiedDate               TIMESTAMP(6),
    CONSTRAINT PK1_1 PRIMARY KEY (ProductSubCategoryID_SK)
)
;



-- 
-- TABLE: DimProductVendor 
--

CREATE TABLE DimProductVendor(
    ProductVendor_ProductID_SK    NUMBER(38, 0)    NOT NULL,
    ProductVendor_ProductID_PK    NUMBER(38, 0)    NOT NULL,
    AverageLoadTime               NUMBER(38, 0)    NOT NULL,
    StandardPrice                 NUMBER(19, 2)    NOT NULL,
    MinOrderqty                   NUMBER(38, 0)    NOT NULL,
    MaxOrderQty                   NUMBER(38, 0)    NOT NULL,
    OnOrderQty                    NUMBER(38, 0)    NOT NULL,
    ProductOrderDetailID          NUMBER(38, 0),
    LastReceiptDate               TIMESTAMP(6),
    DateKey_SK                    TIMESTAMP(6)     NOT NULL,
    CONSTRAINT PK5 PRIMARY KEY (ProductVendor_ProductID_SK)
)
;



-- 
-- TABLE: DimSalesTerritory 
--

CREATE TABLE DimSalesTerritory(
    TerritoryID_SK    NUMBER(38, 0)    NOT NULL,
    TerritoryID_PK    NUMBER(38, 0)    NOT NULL,
    rowguid           RAW(16)          NOT NULL,
    CostLastYear      NUMBER(19, 2)    NOT NULL,
    CostYTD           NUMBER(19, 2)    NOT NULL,
    SalesLastYear     NUMBER(19, 2)    NOT NULL,
    SalesYTD          NUMBER(19, 2)    NOT NULL,
    Group             NVARCHAR2(50)    NOT NULL,
    Name              NVARCHAR2(50)    NOT NULL,
    CONSTRAINT PK1_1_3 PRIMARY KEY (TerritoryID_SK)
)
;



-- 
-- TABLE: DimShipMethod 
--

CREATE TABLE DimShipMethod(
    ShipMethodID_SK    NUMBER(38, 0)    NOT NULL,
    rowguid            RAW(16)          NOT NULL,
    ShipRate           NUMBER(19, 2)    NOT NULL,
    ShipBase           NUMBER(19, 2)    NOT NULL,
    Name               NVARCHAR2(50)    NOT NULL,
    ShipMethodID_PK    NUMBER(38, 0)    NOT NULL,
    CONSTRAINT PK1_1_1_1 PRIMARY KEY (ShipMethodID_SK)
)
;



-- 
-- TABLE: DimVendor 
--

CREATE TABLE DimVendor(
    VendorID_SK                NUMBER(38, 0)      NOT NULL,
    VendorID_PK                NUMBER(38, 0)      NOT NULL,
    PrefferedVendorStatus      RAW(1)             NOT NULL,
    ActiveFlag                 RAW(1)             NOT NULL,
    PurchasingWebServiceURL    NVARCHAR2(1024)    NOT NULL,
    AccountNumber              NVARCHAR2(15)      NOT NULL,
    Name                       NVARCHAR2(50)      NOT NULL,
    CreditRating               NUMBER(3, 0)       NOT NULL,
    GeographyID_SK             NUMBER(38, 0),
    DateKey_SK                 TIMESTAMP(6)       NOT NULL,
    CONSTRAINT PK1_3 PRIMARY KEY (VendorID_SK)
)
;



-- 
-- TABLE: FactOrderDetail 
--

CREATE TABLE FactOrderDetail(
    ProductOrderDetailID    NUMBER(38, 0)    NOT NULL,
    StockedQty              NUMBER(8, 2)     NOT NULL,
    OrderQty                SMALLINT         NOT NULL,
    UnitPrice               NUMBER(19, 2)    NOT NULL,
    LineTotal               NUMBER(19, 2)    NOT NULL,
    RejectedQty             NUMBER(8, 2)     NOT NULL,
    RecievedQty             NUMBER(8, 2)     NOT NULL,
    PurchaseOrderID         NUMBER(38, 0),
    ModifiedDate            TIMESTAMP(6),
    DueDate                 TIMESTAMP(6),
    ProductID_SK            NUMBER(38, 0),
    CONSTRAINT PK3 PRIMARY KEY (ProductOrderDetailID)
)
;



-- 
-- TABLE: FactPurchaseOrderHeader 
--

CREATE TABLE FactPurchaseOrderHeader(
    PurchaseOrderID               NUMBER(38, 0)    NOT NULL,
    RevisionNumber                NUMBER(3, 0)     NOT NULL,
    Status                        NUMBER(3, 0)     NOT NULL,
    TaxAmt                        NUMBER(19, 2)    NOT NULL,
    SubTotal                      NUMBER(19, 2)    NOT NULL,
    TotalDue                      NUMBER(19, 2)    NOT NULL,
    Freight                       NUMBER(19, 2)    NOT NULL,
    EmployeeID_SK                 NUMBER(38, 0),
    VendorID_SK                   NUMBER(38, 0),
    ProductVendor_ProductID_SK    NUMBER(38, 0),
    ShipMethodID_SK               NUMBER(38, 0),
    GeographyID_SK                NUMBER(38, 0),
    ModifiedDate                  TIMESTAMP(6),
    ShipDate                      TIMESTAMP(6),
    OrderDate                     TIMESTAMP(6),
    CONSTRAINT PK2_1 PRIMARY KEY (PurchaseOrderID)
)
;



-- 
-- TABLE: DimEmployee 
--

ALTER TABLE DimEmployee ADD CONSTRAINT RefDimGeography291 
    FOREIGN KEY (GeographyID_SK)
    REFERENCES DimGeography(GeographyID_SK)
;

ALTER TABLE DimEmployee ADD CONSTRAINT RefDimDate451 
    FOREIGN KEY (BirthDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimEmployee ADD CONSTRAINT RefDimDate801 
    FOREIGN KEY (DateKey_SK)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: DimEmployeePay 
--

ALTER TABLE DimEmployeePay ADD CONSTRAINT RefDimEmployee121 
    FOREIGN KEY (EmployeeID_SK)
    REFERENCES DimEmployee(EmployeeID_SK)
;

ALTER TABLE DimEmployeePay ADD CONSTRAINT RefDimDate561 
    FOREIGN KEY (EffectiveDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimEmployeePay ADD CONSTRAINT RefDimDate571 
    FOREIGN KEY (EffectiveDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimEmployeePay ADD CONSTRAINT RefDimDate581 
    FOREIGN KEY (IneffectiveDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimEmployeePay ADD CONSTRAINT RefDimDate641 
    FOREIGN KEY (RateChgeDateDurable_SK)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimEmployeePay ADD CONSTRAINT RefDimDate791 
    FOREIGN KEY (ModifiedDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: DimProduct 
--

ALTER TABLE DimProduct ADD CONSTRAINT RefDimShipMethod241 
    FOREIGN KEY (ShipMethodID_SK)
    REFERENCES DimShipMethod(ShipMethodID_SK)
;

ALTER TABLE DimProduct ADD CONSTRAINT RefDimProductSubCategory351 
    FOREIGN KEY (ProductSubCategoryID_SK)
    REFERENCES DimProductSubCategory(ProductSubCategoryID_SK)
;

ALTER TABLE DimProduct ADD CONSTRAINT RefDimProductModel361 
    FOREIGN KEY (ProductModelID_SK)
    REFERENCES DimProductModel(ProductModelID_SK)
;

ALTER TABLE DimProduct ADD CONSTRAINT RefDimDate371 
    FOREIGN KEY (ModifiedDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProduct ADD CONSTRAINT RefDimProductStandardCost381 
    FOREIGN KEY (ProdCosHisStrDateDurable_SK, ProdCostHistStrDateTable_SK)
    REFERENCES DimProductStandardCost(ProdCosHisStrDateDurable_SK, ProdCosHisStrDateTable_SK)
;

ALTER TABLE DimProduct ADD CONSTRAINT RefDimProductCategory391 
    FOREIGN KEY (ProductCategoryID_SK)
    REFERENCES DimProductCategory(ProductCategoryID_SK)
;


-- 
-- TABLE: DimProductInventory 
--

ALTER TABLE DimProductInventory ADD CONSTRAINT RefDimProduct751 
    FOREIGN KEY (ProductID_SK)
    REFERENCES DimProduct(ProductID_SK)
;

ALTER TABLE DimProductInventory ADD CONSTRAINT RefDimGeography761 
    FOREIGN KEY (LocationID)
    REFERENCES DimGeography(GeographyID_SK)
;

ALTER TABLE DimProductInventory ADD CONSTRAINT RefDimDate871 
    FOREIGN KEY (ModifiedDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: DimProductListPrice 
--

ALTER TABLE DimProductListPrice ADD CONSTRAINT RefDimDate491 
    FOREIGN KEY (ProdLisStrDateDurable_SK)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProductListPrice ADD CONSTRAINT RefDimDate591 
    FOREIGN KEY (IneffectiveDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProductListPrice ADD CONSTRAINT RefDimDate611 
    FOREIGN KEY (EffectiveDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProductListPrice ADD CONSTRAINT RefDimDate781 
    FOREIGN KEY (ModifiedDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProductListPrice ADD CONSTRAINT RefDimDate851 
    FOREIGN KEY (EndDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: DimProductStandardCost 
--

ALTER TABLE DimProductStandardCost ADD CONSTRAINT RefDimDate501 
    FOREIGN KEY (ProdCosHisStrDateTable_SK)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProductStandardCost ADD CONSTRAINT RefDimDate601 
    FOREIGN KEY (IneffectiveDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProductStandardCost ADD CONSTRAINT RefDimDate631 
    FOREIGN KEY (EffectiveDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProductStandardCost ADD CONSTRAINT RefDimDate821 
    FOREIGN KEY (ModifiedDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProductStandardCost ADD CONSTRAINT RefDimDate831 
    FOREIGN KEY (EndDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: DimProductSubCategory 
--

ALTER TABLE DimProductSubCategory ADD CONSTRAINT RefDimDate441 
    FOREIGN KEY (ModifiedDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: DimProductVendor 
--

ALTER TABLE DimProductVendor ADD CONSTRAINT RefFactOrderDetail131 
    FOREIGN KEY (ProductOrderDetailID)
    REFERENCES FactOrderDetail(ProductOrderDetailID)
;

ALTER TABLE DimProductVendor ADD CONSTRAINT RefDimDate481 
    FOREIGN KEY (LastReceiptDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE DimProductVendor ADD CONSTRAINT RefDimDate771 
    FOREIGN KEY (DateKey_SK)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: DimSalesTerritory 
--

ALTER TABLE DimSalesTerritory ADD CONSTRAINT RefDimGeography191 
    FOREIGN KEY (TerritoryID_SK)
    REFERENCES DimGeography(GeographyID_SK)
;


-- 
-- TABLE: DimVendor 
--

ALTER TABLE DimVendor ADD CONSTRAINT RefDimGeography311 
    FOREIGN KEY (GeographyID_SK)
    REFERENCES DimGeography(GeographyID_SK)
;

ALTER TABLE DimVendor ADD CONSTRAINT RefDimDate811 
    FOREIGN KEY (DateKey_SK)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: FactOrderDetail 
--

ALTER TABLE FactOrderDetail ADD CONSTRAINT RefFactPurchaseOrderHeader151 
    FOREIGN KEY (PurchaseOrderID)
    REFERENCES FactPurchaseOrderHeader(PurchaseOrderID)
;

ALTER TABLE FactOrderDetail ADD CONSTRAINT RefDimDate281 
    FOREIGN KEY (ModifiedDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactOrderDetail ADD CONSTRAINT RefDimProduct341 
    FOREIGN KEY (ProductID_SK)
    REFERENCES DimProduct(ProductID_SK)
;

ALTER TABLE FactOrderDetail ADD CONSTRAINT RefDimDate551 
    FOREIGN KEY (DueDate)
    REFERENCES DimDate(DateKey_SK)
;


-- 
-- TABLE: FactPurchaseOrderHeader 
--

ALTER TABLE FactPurchaseOrderHeader ADD CONSTRAINT RefDimEmployee181 
    FOREIGN KEY (EmployeeID_SK)
    REFERENCES DimEmployee(EmployeeID_SK)
;

ALTER TABLE FactPurchaseOrderHeader ADD CONSTRAINT RefDimVendor251 
    FOREIGN KEY (VendorID_SK)
    REFERENCES DimVendor(VendorID_SK)
;

ALTER TABLE FactPurchaseOrderHeader ADD CONSTRAINT RefDimProductVendor261 
    FOREIGN KEY (ProductVendor_ProductID_SK)
    REFERENCES DimProductVendor(ProductVendor_ProductID_SK)
;

ALTER TABLE FactPurchaseOrderHeader ADD CONSTRAINT RefDimShipMethod321 
    FOREIGN KEY (ShipMethodID_SK)
    REFERENCES DimShipMethod(ShipMethodID_SK)
;

ALTER TABLE FactPurchaseOrderHeader ADD CONSTRAINT RefDimGeography331 
    FOREIGN KEY (GeographyID_SK)
    REFERENCES DimGeography(GeographyID_SK)
;

ALTER TABLE FactPurchaseOrderHeader ADD CONSTRAINT RefDimDate431 
    FOREIGN KEY (ModifiedDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactPurchaseOrderHeader ADD CONSTRAINT RefDimDate521 
    FOREIGN KEY (ShipDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactPurchaseOrderHeader ADD CONSTRAINT RefDimDate531 
    FOREIGN KEY (ShipDate)
    REFERENCES DimDate(DateKey_SK)
;

ALTER TABLE FactPurchaseOrderHeader ADD CONSTRAINT RefDimDate541 
    FOREIGN KEY (OrderDate)
    REFERENCES DimDate(DateKey_SK)
;



-----1.Ranked order of Vendors by purchase amount $

 

SELECT rank() over(
                   ORDER BY sum(poh.TotalDue) DESC) AS 'Rank',
       pv.BusinessEntityID,
       pv.Name,
       sum(poh.TotalDue) AS 'Purchase Amount'
FROM Purchasing.Vendor AS pv
JOIN Purchasing.PurchaseOrderHeader AS poh ON poh.VendorID = pv.BusinessEntityID
GROUP BY pv.BusinessEntityID,
         pv.Name;

 

-----2.Ranked order of products purchased by amount $

--i) By Category

 

SELECT ppc.Name,
       sum(ppod.LineTotal) AS 'Purchasing Amount'
FROM Production.Product AS pp
JOIN Production.ProductSubcategory AS ppsc ON ppsc.ProductSubcategoryID = pp.ProductSubcategoryID
JOIN Production.ProductCategory AS ppc ON ppc.ProductCategoryID = ppsc.ProductCategoryID
JOIN Purchasing.PurchaseOrderDetail AS ppod ON ppod.ProductID = pp.ProductID
JOIN Purchasing.PurchaseOrderHeader AS ppoh ON ppoh.PurchaseOrderID = ppod.PurchaseOrderID
GROUP BY ppc.Name
ORDER BY sum(ppod.LineTotal) DESC;

 

--ii) By SubCategory

 
SELECT ppsc.Name,
       sum(ppod.LineTotal) AS 'Purchasing Amount'
FROM Production.Product AS pp
JOIN Production.ProductSubcategory AS ppsc ON ppsc.ProductSubcategoryID = pp.ProductSubcategoryID
JOIN Production.ProductCategory AS ppc ON ppc.ProductCategoryID = ppsc.ProductCategoryID
JOIN Purchasing.PurchaseOrderDetail AS ppod ON ppod.ProductID = pp.ProductID
JOIN Purchasing.PurchaseOrderHeader AS ppoh ON ppoh.PurchaseOrderID = ppod.PurchaseOrderID
GROUP BY ppsc.Name
order by sum(ppod.LineTotal) desc

 

--iii)By ProductModel (top 20) 

SELECT top 20 ppm.Name,
           sum(ppod.LineTotal) AS 'Purchasing Amount'
FROM Production.Product AS pp
JOIN Production.ProductSubcategory AS ppsc ON ppsc.ProductSubcategoryID = pp.ProductSubcategoryID
JOIN Production.ProductCategory AS ppc ON ppc.ProductCategoryID = ppsc.ProductCategoryID
JOIN Purchasing.PurchaseOrderDetail AS ppod ON ppod.ProductID = pp.ProductID
JOIN Purchasing.PurchaseOrderHeader AS ppoh ON ppoh.PurchaseOrderID = ppod.PurchaseOrderID
JOIN Production.ProductModel AS ppm ON ppm.ProductModelID = pp.ProductModelID
GROUP BY ppm.Name
ORDER BY sum(ppod.LineTotal) DESC;

 

--iv) By Product (top 20)

 

SELECT top 20 pp.Name,
           sum(ppod.LineTotal) AS 'Purchasing Amount'
FROM Production.Product AS pp
JOIN Production.ProductSubcategory AS ppsc ON ppsc.ProductSubcategoryID = pp.ProductSubcategoryID
JOIN Production.ProductCategory AS ppc ON ppc.ProductCategoryID = ppsc.ProductCategoryID
JOIN Purchasing.PurchaseOrderDetail AS ppod ON ppod.ProductID = pp.ProductID
JOIN Purchasing.PurchaseOrderHeader AS ppoh ON ppoh.PurchaseOrderID = ppod.PurchaseOrderID
JOIN Production.ProductModel AS ppm ON ppm.ProductModelID = pp.ProductModelID
GROUP BY pp.Name
ORDER BY sum(ppod.LineTotal) DESC

 
-----3.List of employees who purchased products with phone, email & address

 SELECT CONCAT(pp.LastName, ' ', pp.FirstName) AS 'Employee Name',
       pea.EmailAddress,
       pa.AddressLine1,
       ppp.PhoneNumber,
       SUM(ppoh.TotalDue) AS 'Purchase Amount'
FROM HumanResources.Employee AS hre
JOIN Person.BusinessEntityAddress AS pbea ON hre.BusinessEntityID = pbea.BusinessEntityID
JOIN Person.Address AS pa ON pa.AddressID = pbea.AddressID
JOIN Person.PersonPhone AS ppp ON ppp.BusinessEntityID = hre.BusinessEntityID
JOIN Person.EmailAddress AS pea ON pea.BusinessEntityID = hre.BusinessEntityID
JOIN Purchasing.PurchaseOrderHeader AS ppoh ON hre.BusinessEntityID = ppoh.EmployeeID
JOIN Person.Person AS pp ON pp.BusinessEntityID = hre.BusinessEntityID
GROUP BY CONCAT(pp.LastName, ' ', pp.FirstName),
         hre.BusinessEntityID,
         ppp.PhoneNumber,
         pea.EmailAddress,
         pa.AddressLine1
ORDER BY SUM(ppoh.TotalDue)
 

 

-----4.List of employees who purchased products with pay rate & raises (SCD)

 

SELECT CONCAT(pp.LastName, ' ', pp.FirstName) AS 'Employee Name',
       eph.Rate,
       eph.RateChangeDate,
       eph.ModifiedDate
FROM HumanResources.Employee AS hre
JOIN HumanResources.EmployeePayHistory AS eph ON hre.BusinessEntityID = eph.BusinessEntityID
JOIN Person.Person AS pp ON pp.BusinessEntityID = hre.BusinessEntityID
GROUP BY CONCAT(pp.LastName, ' ', pp.FirstName),
         eph.Rate,
         eph.ModifiedDate,
         eph.RateChangeDate
ORDER BY eph.ModifiedDate;
 

-----5.List of purchasing vendor contacts with vendor name, phone, email & address


SELECT pv.Name,
       pvc.PhoneNumber,
       pvc.EmailAddress,
       pva.AddressLine1
FROM Purchasing.Vendor AS pv
JOIN Purchasing.vVendorWithAddresses AS pva ON pv.BusinessEntityID = pva.BusinessEntityID
JOIN Purchasing.vVendorWithContacts AS pvc ON pv.BusinessEntityID = pvc.BusinessEntityID
GROUP BY pv.Name,
         pvc.PhoneNumber,
         pvc.EmailAddress,
         pva.AddressLine1;

 

-----6.List of product prices by product order by product and SCD effective ascending

 

SELECT pp.Name,
       plph.ListPrice,
       plph.ModifiedDate
FROM Production.Product AS pp
JOIN Production.ProductListPriceHistory AS plph ON pp.ProductID = plph.ProductID
GROUP BY pp.Name,
         plph.ListPrice,
         plph.ModifiedDate
ORDER BY plph.ModifiedDate ASC;

 

 

-----7.List of standard costs by product order by product and SCD effective ascending

SELECT pp.Name,
       pch.StandardCost,
       pch.ModifiedDate
FROM Production.Product AS pp
JOIN Production.ProductCostHistory AS pch ON pch.ProductID = pp.ProductID
GROUP BY pp.Name,
         pch.StandardCost,
         pch.ModifiedDate
ORDER BY pch.ModifiedDate ASC;

-----1.Ranked order of Vendors by purchase amount $

SELECT rank() over(
                   ORDER BY sum(poh.TotalDue) DESC) AS 'Rank',
       pv.VendorID_SK,
       pv.Name,
       sum(poh.TotalDue) AS 'Purchase Amount'
FROM dimvendor AS pv
JOIN FactPurchaseOrderHeader AS poh ON poh.VendorID_SK = pv.VendorID_SK
GROUP BY pv.VendorID_SK,
         pv.Name;
         
-----2.Ranked order of products purchased by amount $

--i) By Category
SELECT ppc.Name,
       sum(ppod.LineTotal) AS 'Purchasing Amount'
FROM dimproduct AS pp
JOIN dimproductsubcategory AS ppsc ON ppsc.ProductSubcategoryID_SK = pp.ProductSubcategoryID_SK
JOIN dimproductcategory AS ppc ON ppc.ProductCategoryID_SK = pp.ProductCategoryID_SK
JOIN factorderdetail AS ppod ON ppod.ProductID_SK = pp.ProductID_SK
JOIN factpurchaseorderheader AS ppoh ON ppoh.PurchaseOrderID = ppod.PurchaseOrderID
GROUP BY ppc.Name
ORDER BY sum(ppod.LineTotal) DESC;

--ii) By SubCategory

SELECT ppsc.Name,
       sum(ppod.LineTotal) AS 'Purchasing Amount'
FROM Production.Product AS pp
JOIN dimproductsubcategory AS ppsc ON ppsc.ProductSubcategoryID_SK = pp.ProductSubcategoryID_SK
JOIN dimproductcategory AS ppc ON ppc.ProductCategoryID_SK = pp.ProductCategoryID_SK
JOIN factorderdetail AS ppod ON ppod.ProductID_SK = pp.ProductID_SK
JOIN factpurchaseorderheader AS ppoh ON ppoh.PurchaseOrderID = ppod.PurchaseOrderID
GROUP BY ppsc.Name
order by sum(ppod.LineTotal) desc


--iii)By ProductModel (top 20) 

SELECT top 20 ppm.Name,
           sum(ppod.LineTotal) AS 'Purchasing Amount'
FROM Production.Product AS pp
JOIN dimproductsubcategory AS ppsc ON ppsc.ProductSubcategoryID_SK = pp.ProductSubcategoryID_SK
JOIN dimproductcategory AS ppc ON ppc.ProductCategoryID_SK = pp.ProductCategoryID_SK
JOIN factorderdetail AS ppod ON ppod.ProductID_SK = pp.ProductID_SK
JOIN factpurchaseorderheader AS ppoh ON ppoh.PurchaseOrderID = ppod.PurchaseOrderID
JOIN dimproductmodel AS ppm ON ppm.ProductModelID_SK = pp.ProductModelID_SK
GROUP BY ppm.Name
ORDER BY sum(ppod.LineTotal) DESC;

--iv) By Product (top 20)

SELECT top 20 pp.Name,
           sum(ppod.LineTotal) AS 'Purchasing Amount'
FROM Production.Product AS pp
JOIN dimproductsubcategory AS ppsc ON ppsc.ProductSubcategoryID_SK = pp.ProductSubcategoryID_SK
JOIN dimproductcategory AS ppc ON ppc.ProductCategoryID_SK = pp.ProductCategoryID_SK
JOIN factorderdetail AS ppod ON ppod.ProductID_SK = pp.ProductID_SK
JOIN factpurchaseorderheader AS ppoh ON ppoh.PurchaseOrderID = ppod.PurchaseOrderID
JOIN dimproductmodel AS ppm ON ppm.ProductModelID_SK = pp.ProductModelID_SK
GROUP BY pp.Name
ORDER BY sum(ppod.LineTotal) DESC

#6.List of product prices by product order by product and SCD effective ascending

SELECT p.Name,
       plp.ListPrice,
       p.ModifiedDate
FROM DimProduct AS p
JOIN DimProductListPrice AS plp ON p.ProductID_SK = plp.ProductID
GROUP BY p.Name,
         plp.ListPrice,
         p.ModifiedDate
ORDER BY p.ModifiedDate ASC;

#7.List of standard costs by product order by product and SCD effective ascending

SELECT p.Name,
       psc.CostPrice,
       p.ModifiedDate
FROM dimproduct AS p
JOIN DimProductStandardCost AS psc ON psc.ProductSubCategoryID_SK = p.ProductID_SK
GROUP BY p.Name,
         psc.CostPrice,
         p.ModifiedDate
ORDER BY prsc.ModifiedDate ASC;


#5.List of purchasing vendor contacts with vendor name, phone, email & address


SELECT v.Name,
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


#4 .List of employees who purchased products with pay rate & raises (SCD)

 
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
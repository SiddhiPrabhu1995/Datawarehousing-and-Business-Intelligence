

--1. total sales 
select SUM(il.Quantity*il.UnitPrice ) as TotalSales from InvoiceLine il



--2. total sales by country ranked 
select ROW_NUMBER() OVER(ORDER BY (SUM(il.Quantity*il.UnitPrice))desc) as 'Rank',i.BillingCountry, SUM(il.Quantity*il.UnitPrice ) as TotalSales
from Invoice i 
join InvoiceLine il on il.InvoiceId=i.InvoiceId
join Customer c on c.CustomerId=i.CustomerId 
GROUP by i.BillingCountry

--
--3. total sales by country state and city 

select c.Country,c.State,c.City, SUM(il.Quantity*il.UnitPrice ) as TotalSales  
from Invoice i 
join InvoiceLine il on il.InvoiceId=i.InvoiceId
join Customer c on c.CustomerId=i.CustomerId 
GROUP by c.Country,c.State,c.City ORDER BY (SUM(il.Quantity*il.UnitPrice)) desc

--4.total sales by customer ranked 
select ROW_NUMBER() OVER(ORDER BY (SUM(il.Quantity*il.UnitPrice))desc) as 'Rank',c.CustomerId ,CONCAT(c.FirstName,',',LastName) as NAME, SUM(il.Quantity*il.UnitPrice ) as TotalSales
from Invoice i 
join InvoiceLine il on il.InvoiceId=i.InvoiceId
join Customer c on c.CustomerId=i.CustomerId 
GROUP by  c.FirstName,c.LastName,c.CustomerId

--5. total sales by artist ranked 
select ROW_NUMBER() OVER(ORDER BY (SUM(il.Quantity*il.UnitPrice))desc) as 'rank',at.Name as NAME, SUM(il.Quantity*il.UnitPrice ) as TotalSales 
from InvoiceLine il 
join Track t on il.TrackId=t.TrackId
join album a on a.AlbumId=t.AlbumId 
join artist at on a.ArtistId=at.ArtistId
GROUP by at.Name

--6 total sales by album 
select a.Title as Album, SUM(il.Quantity*il.UnitPrice ) as TotalSales 
from InvoiceLine il 
join Track t on il.TrackId=t.TrackId
join album a on a.AlbumId=t.AlbumId 
GROUP by a.Title ORDER BY (SUM(il.Quantity*il.UnitPrice)) DESC

--7 total sales by sales person employee 


select CONCAT(e.FirstName,',',e.LastName) as NAME, SUM(il.Quantity*il.UnitPrice ) as TotalSales
from Invoice i 
join InvoiceLine il on il.InvoiceId=i.InvoiceId
join Customer c on c.CustomerId=i.CustomerId 
join Employee e on e.EmployeeId=c.SupportRepId
GROUP by  e.FirstName,e.LastName  ORDER BY (SUM(il.Quantity*il.UnitPrice))desc

--8 total tracks bought and total revenue by media type 


select m.Name as MediaType, SUM(il.Quantity*il.UnitPrice ) as TotalRevenue, COUNT(t.TrackId) as TotalTracksBought 
from InvoiceLine il 
join Track t on il.TrackId=t.TrackId
join MediaType m on m.MediaTypeId=t.MediaTypeId
GROUP by m.Name ORDER BY (SUM(il.Quantity*il.UnitPrice)) DESC

--9. total sales by customer 

 
select c.CustomerId,CONCAT(c."FirstName",',',c."LastName") as CustomerName, SUM(il.Quantity*il.UnitPrice ) as TotalSales from Invoice i 
join InvoiceLine il on il.InvoiceId=i.InvoiceId
join Customer c on c.CustomerId=i.CustomerId 
GROUP by  c.CustomerId,CONCAT(c."FirstName",',',c."LastName") ORDER BY (SUM(il.Quantity*il.UnitPrice))

--10 total sales by genre


select g.Name as NAME, SUM(il.Quantity*il.UnitPrice ) as TotalRevenue
from InvoiceLine il 
join Track t on il.TrackId=t.TrackId
join genre g on g.GenreId=t.GenreId
GROUP by g.Name ORDER BY (SUM(il.Quantity*il.UnitPrice)) DESC



 









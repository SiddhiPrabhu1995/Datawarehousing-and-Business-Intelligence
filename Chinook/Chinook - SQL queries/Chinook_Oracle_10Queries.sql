
--1. total sales 
select SUM(il.Quantity*il.UnitPrice ) as TotalSales from InvoiceLine il


--2. total sales by country ranked 
SELECT row_number() OVER(ORDER BY (SUM(il.Quantity*il.UnitPrice))desc) as Rank,i.BillingCountry, SUM(il.Quantity*il.UnitPrice ) as TotalSales
from Invoice i 
join InvoiceLine il on il.InvoiceId=i.InvoiceId
join Customer c on c.CustomerId=i.CustomerId 
GROUP by i.BillingCountry

--3. total sales by country state and city 

select c.Country,c.State,c.City, SUM(il.Quantity*il.UnitPrice ) as TotalSales  
from Invoice i 
join InvoiceLine il on il.InvoiceId=i.InvoiceId
join Customer c on c.CustomerId=i.CustomerId 
GROUP by c.Country,c.State,c.City ORDER BY (SUM(il.Quantity*il.UnitPrice)) desc

--4.total sales by customer ranked 
select row_number() OVER(ORDER BY (SUM(il.Quantity*il.UnitPrice))desc) as Rank ,CONCAT(CONCAT(c.FirstName,' '),LastName) as NAME, SUM(il.Quantity*il.UnitPrice ) as TotalSales
from Invoice i 
join InvoiceLine il on il.InvoiceId=i.InvoiceId
join Customer c on c.CustomerId=i.CustomerId 
GROUP by  c.FirstName,LastName

--5. total sales by artist ranked 
select ROW_NUMBER() OVER(ORDER BY (SUM(il.Quantity*il.UnitPrice))desc) as Rank,at.Name as NAME, SUM(il.Quantity*il.UnitPrice ) as TotalSales 
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


select CONCAT(CONCAT(e.FirstName,' '),e.LastName) as NAME, SUM(il.Quantity*il.UnitPrice ) as TotalSales
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

--9. total sales by customer(company) 

 
select c.CustomerId,c.Company as NAME, SUM(il.Quantity*il.UnitPrice ) as TotalSales from Invoice i 
join InvoiceLine il on il.InvoiceId=i.InvoiceId
join Customer c on c.CustomerId=i.CustomerId WHERE c.Company IS NOT NULL
GROUP by  c.CustomerId,c.Company ORDER BY (SUM(il.Quantity*il.UnitPrice))

--10 total sales by genre


select g.Name as NAME, SUM(il.Quantity*il.UnitPrice ) as TotalRevenue
from InvoiceLine il 
join Track t on il.TrackId=t.TrackId
join genre g on g.GenreId=t.GenreId
GROUP by g.Name ORDER BY (SUM(il.Quantity*il.UnitPrice)) DESC



 






--


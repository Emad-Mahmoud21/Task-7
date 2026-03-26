-- Chinook Database

-- Q1: first name, last name, and email of all customers
select FirstName, LastName, Email
from Customer;

-- Q2: all invoices
select InvoiceId, CustomerId, InvoiceDate, Total
from Invoice;

-- Q3: all invoice lines
select InvoiceId, TrackId, UnitPrice, Quantity
from InvoiceLine;

-- Q4: customers from USA
select FirstName, LastName, Country
from Customer
where Country = 'USA';

-- Q5: invoices where total > 10
select InvoiceId, Total
from Invoice
where Total > 10;

-- Q6: customers with their invoices
select c.CustomerId, c.FirstName, c.LastName, i.InvoiceId, i.Total
from Customer c
join Invoice i on c.CustomerId = i.CustomerId;

-- Q7: invoice details with customer name
select i.InvoiceId, i.InvoiceDate, c.FirstName, c.LastName
from Invoice i
join Customer c on i.CustomerId = c.CustomerId;

-- Q8: invoice lines with invoice date
select il.InvoiceId, il.TrackId, il.Quantity, il.UnitPrice, i.InvoiceDate
from InvoiceLine il
join Invoice i on il.InvoiceId = i.InvoiceId;

-- Q9: customers who have at least one invoice
select CustomerId, FirstName, LastName
from Customer
where CustomerId in (
    select distinct CustomerId
    from Invoice
);

-- Q10: customers whose total spending > average invoice total
select c.CustomerId, c.FirstName, c.LastName, sum(i.Total) as TotalSpent
from Customer c
join Invoice i on c.CustomerId = i.CustomerId
group by c.CustomerId, c.FirstName, c.LastName
having sum(i.Total) > (
    select avg(Total)
    from Invoice
);

-- Q11: invoices where total > average invoice total
select InvoiceId, Total
from Invoice
where Total > (
    select avg(Total)
    from Invoice
);

-- Q12: number of invoices per customer
select c.CustomerId, c.FirstName, c.LastName, count(i.InvoiceId) as InvoiceCount
from Customer c
join Invoice i on c.CustomerId = i.CustomerId
group by c.CustomerId, c.FirstName, c.LastName;

-- Q13: invoices with more than 3 items
select i.InvoiceId, i.Total
from Invoice i
where i.InvoiceId in (
    select InvoiceId
    from InvoiceLine
    group by InvoiceId
    having sum(Quantity) > 3
);

-- Q14: customers who never made an invoice
select CustomerId, FirstName, LastName
from Customer
where CustomerId not in (
    select distinct CustomerId
    from Invoice
);

-- Q15: invoices for customers from Canada
select InvoiceId, CustomerId, Total
from Invoice
where CustomerId in (
    select CustomerId
    from Customer
    where Country = 'Canada'
);

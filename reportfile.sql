select * from orders ,books
select * from books
select * from customer 

-- 1) Retrieve all books in the "Fiction" genre:

select * from books
where genre = 'Fiction'


-- 2) Find books published after the year 1950:

select * from books
where published_year = 1950;



-- 3) List all customers from the Canada:


select * from customer 
where country = 'Canada';


-- 4) Show orders placed in November 2023:

select * from orders 
where order_date between '2023-11-01' and '2023-11-30' 


-- 5) Retrieve the total stock of books available:

(select sum(stock) as total_stock from books)


-- 6) Find the details of the most expensive book:

select * from books
order by price desc
limit 1
--------------------------------
select * from books 
where price =( select max(price) from books)


-- 7) Show all customers who ordered more than 1 quantity of a book:

select * from orders
where quantity > 1


-- 8) Retrieve all orders where the total amount exceeds $20:

select * from orders 
where Total_amount >= 20.00;


-- 9) List all genres available in the Books table:

SELECT DISTINCT genre FROM Books;




-- 10) Find the book with the lowest stock:


select * from books
where stock = (select min(stock) as lowest_stock from books)

SELECT * FROM Books 
ORDER BY stock 
LIMIT 1;


-- 11) Calculate the total revenue generated from all orders:
select * from orders
where Total_amount =
(SELECT SUM(total_amount) As Revenue 
FROM Orders)



-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:

select * from orders;
select b.genre, sum(o.quantity) as Total_number_sold 
from orders o
join books b on o.book_id = b.book_id 
group by genre

-- 2) Find the average price of books in the "Fantasy" genre:

select avg(price) from books 
where genre = 'Fantasy';


-- 3) List customers who have placed at least 2 orders:

select o.customer_id, c.name , count(o.order_id) from orders o
join customer c on o.customer_id = c.customer_id 
group by o.customer_id, c.name
having count (order_id) >= 2;








-- 4) Find the most frequently ordered book:



SELECT o.Book_id, b.tital, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.tital
ORDER BY ORDER_COUNT DESC LIMIT 1;



-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

select * from books 
where genre ='Fantasy'
order by price desc
limit 3


-- 6) Retrieve the total quantity of books sold by each author:


select b.auther as Name_of_auther, sum(o.quantity) as Total_quantity_soild 
from orders o
join books b on o.book_id = b.book_id
group by b.auther 

-- 7) List the cities where customers who spent over $30 are located:


select c.name as customer_name, c.city as City, o.Total_amount 
from orders o
join customer c on o.customer_id = c.customer_id 
where Total_amount >= 30

SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customer c ON o.customer_id=c.customer_id
WHERE o.total_amount > 30;


-- 8) Find the customer who spent the most on orders:

select c.name, c.city, max(o.total_amount) as Most_spent_orders
from orders o
join customer c on o.customer_id = c.customer_id
group by c.name , c.city
order by Most_spent_orders desc limit 5



--9) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.tital, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock - COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;












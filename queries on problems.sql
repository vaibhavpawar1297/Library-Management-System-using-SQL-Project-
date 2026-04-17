SELECT * from employees;
SELECT * from books;
SELECT * from branch;
SELECT * from return_status;
SELECT * from members;
SELECT * from issued_status;

-- Project Task

-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;


-- Task 2: Update an Existing Member's Address

UPDATE members
SET member_address = '1297 Main Vp'
WHERE member_id = 'C102';
SELECT * FROM members;


-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

SELECT * FROM issued_status
WHERE issued_id = 'IS121';

DELETE FROM issued_status
WHERE issued_id = 'IS121'



-- Task 4: Retrieve All Books Issued by a Specific Employee 
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';

-- Task 5: List Members Who Have Issued More Than One Book 
-- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT
   issued_emp_id,
   COUNT(issued_id)
   FROM issued_status
   GROUP BY issued_emp_id
   HAVING COUNT(*) > 1;

SELECT 
    ist.issued_emp_id,
     e.emp_name
FROM issued_status as ist
JOIN
employees as e
ON e.emp_id = ist.issued_emp_id
GROUP BY 1, 2
HAVING COUNT(*) > 1


-- CTAS     create table as select
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - 
-- each book and total book_issued_cnt**
CREATE TABLE book_cnts
AS
SELECT 
	b.isbn, b.book_title,
	COUNT(ist.issued_id) as no_issued
	FROM books as b
	JOIN issued_status as ist
	on ist.issued_book_isbn = b.isbn
	GROUP BY 1,2;

select * from book_cnts;

-- Task 7. Retrieve All Books in a Specific Category:
SELECT * FROM books
WHERE category= 'Classic';

-- Task 8: Find Total Rental Income by each Category:
SELECT 
     b.category,
	 sum(b.rental_price) AS Rental_Income,
	 COUNT(*)
FROM books as b
	JOIN issued_status as ist
	on ist.issued_book_isbn = b.isbn
	GROUP BY 1;

--Task 9: List Members Who Registered in the Last 180 Days:
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days'  


INSERT INTO members(member_id, member_name, member_address, reg_date)
VALUES
('C120', 'Simba', '1415 Main St', '2025-06-01'),
('C121', 'Jaggu', '1213 Main St', '2026-05-01');

-- task 10: List Employees with Their Branch Manager's Name and their branch details:

SELECT * from branch;
SELECT * from employees;

SELECT 
	    e1.*,
	    b.manager_id,
	    e2.emp_name as manager 
 FROM employees as e1
 JOIN branch as b
 on b.branch_id = e1.branch_id
 JOIN 
 employees as e2
 on b.manager_id = e2.emp_id;

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:
CREATE TABLE books_price_greater_than_seven
AS    
SELECT * FROM Books
WHERE rental_price > 7

SELECT * FROM 
books_price_greater_than_seven

-- Task 12: Retrieve the List of Books Not Yet Returned
SELECT 
    DISTINCT ist.issued_book_name
FROM issued_status as ist
LEFT JOIN
return_status as rs
ON ist.issued_id = rs.issued_id
WHERE rs.return_id IS NULL

    
SELECT * FROM return_status








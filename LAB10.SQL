CREATE DATABASE lab10;

CREATE TABLE books(
    book_id INT PRIMARY KEY,
    title VARCHAR,
    author VARCHAR,
    price DECIMAL,
    quantity INT
);

CREATE TABLE orders(
    order_id INT PRIMARY KEY,
    book_id INT references books(book_id),
    customer_id INT,
    order_date DATE,
    quantity INT
);

CREATE TABLE customers(
    customer_id INT PRIMARY KEY,
    name VARCHAR,
    email VARCHAR
);

INSERT INTO books values(1, 'Database 101', 'A.Smith', 40.00, 10),
                         (2, 'Learn SQL', 'B.Johnson', 35.00, 15),
                         (3, 'Advanced DB', 'C.Lee', 50.00, 5);

INSERT INTO customers values(101,  'John Doe', 'johndoe@example.com'),
                         (102, 'Jane Doe', 'janedoe@example.com');

--1
BEGIN;

INSERT INTO orders (order_id, book_id, customer_id, order_date, quantity)
VALUES (1, 1, 101, CURRENT_DATE, 2);
UPDATE books
SET quantity = quantity - 2
WHERE book_id = 1;

COMMIT;

select * from orders;
select * from books;

--2
-- begin;
-- INSERT INTO orders (order_id, book_id, customer_id, order_date, quantity)
-- VALUES (2, 3, 102, CURRENT_DATE, 10);
-- IF (SELECT quantity FROM books WHERE book_id = 3) <= 10 THEN
--     ROLLBACK;
--     RETURN;
-- END IF;
-- UPDATE books
-- SET quantity = quantity - 10
-- WHERE book_id = 3;
--
-- COMMIT;

DO $$
BEGIN
    INSERT INTO orders (order_id, book_id, customer_id, order_date, quantity)
    VALUES (2, 3, 102, CURRENT_DATE, 10);

    IF (SELECT quantity FROM books WHERE book_id = 3) <= 10 THEN
        ROLLBACK;
        RETURN;
    END IF;

    UPDATE books
    SET quantity = quantity - 10
    WHERE book_id = 3;

    COMMIT;
END;
$$ LANGUAGE plpgsql;

--3
begin transaction isolation level read committed;
update books
set price = price + 10
where book_id = 1;
commit;
begin transaction isolation level read committed;
select books.price from books
where book_id = 1;

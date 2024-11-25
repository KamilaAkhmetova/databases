CREATE DATABASE lab9;

-- 1
CREATE FUNCTION increase_value(p1 int)
RETURNS INT AS $$
    BEGIN
    RETURN p1 + 10;
    END;
    $$
LANGUAGE plpgsql;

--2
CREATE FUNCTION compare_numbers(p1 int, p2 int, out result varchar)
    AS $$ BEGIN
IF p1>p2 THEN
    SET result = 'Greater';
ELSEIF p1 = p2 THEN
    SET result = 'Equal';
ELSE
    SET result = 'Lesser';
    END IF;
    END; $$
LANGUAGE plpgsql;

--3
CREATE FUNCTION number_series(n INT)
    RETURNS TEXT AS
$$
    DECLARE res TEXT := '';
    BEGIN
        FOR i IN 1..n LOOP
            res := res || i || ' ';
            end loop;
        RETURN res;
    end;
$$
LANGUAGE plpgsql;

--4

CREATE TABLE employees(
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    salary INT
);


CREATE FUNCTION find_employee (employee_name varchar)
RETURNS TABLE (id INT, first_name varchar, last_name varchar, email varchar, salary INT) AS
    $$
    BEGIN
RETURN QUERY SELECT id, first_name, last_name, email, salary FROM employees
WHERE first_name = employee_name;
end;$$
LANGUAGE plpgsql;

--5

CREATE TABLE products(
    id SERIAL PRIMARY KEY,
    name VARCHAR,
    category VARCHAR
    );

CREATE FUNCTION list_products(category_name int)
RETURNS TABLE(id INT,name VARCHAR, category VARCHAR)
AS $$
    BEGIN
        RETURN QUERY SELECT id, name, category FROM products
WHERE category = category_name;
        end;
$$
LANGUAGE plpgsql;



--6
CREATE FUNCTION calculate_bonus(id int)
RETURNS int as
    $$
    DECLARE bonus int;
    BEGIN
SELECT employees.salary * 0.15 INTO bonus FROM employees
WHERE employees.employee_id = id;
RETURN bonus;
end;$$
LANGUAGE plpgsql;

CREATE FUNCTION update_salary(id int)
RETURNS TABLE(employee_id int, first_name varchar, last_name varchar, email varchar, salary int)
AS $$
    DECLARE bonus int;
BEGIN
bonus := calculate_bonus(id );
RETURN QUERY UPDATE employees SET salary = salary + bonus
    WHERE employee_id = id
    RETURNING *;
end;
$$
LANGUAGE plpgsql;

--7
CREATE FUNCTION complex_calculation(salary INT, domain_filter VARCHAR)
RETURNS VARCHAR AS $$
DECLARE
    annual_salary INT;
    kbtu_email VARCHAR;
BEGIN
    -- Main block: Encloses the entire logic
    BEGIN
        -- First subblock: Numeric computation
        BEGIN
            -- Calculate the annual salary
            annual_salary := salary * 12;
        END;

        -- Second subblock: String manipulation
        BEGIN
            -- Retrieve email that matches the given domain filter
            SELECT email
            INTO kbtu_email
            FROM employees
            WHERE email LIKE '%' || domain_filter;
        END;

        -- Combine results from subblocks and return
        RETURN 'Annual Salary: ' || annual_salary ||
               ', Email: ' || COALESCE(kbtu_email, 'Not found');
    END;
END;
$$ LANGUAGE plpgsql;

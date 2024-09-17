--1
CREATE DATABASE lab2;

--2
CREATE TABLE countries(
    country_id SERIAL PRIMARY KEY,
    country_name varchar,
    region_id int,
    population int
);

--3
INSERT INTO countries(country_name, region_id, population)
VALUES('Kazakhstan', 1, 20000000);

--4
INSERT INTO countries(country_id, country_name)
VALUES(2, 'Japan');

--5
INSERT INTO countries(region_id)
VALUES(NULL);

--6
INSERT INTO countries(country_name, region_id, population)
VALUES('Germany', 2, 83000000),
('Hong Kong', 3, 7000000),
('France',4, 68000000);

--7
ALTER TABLE countries
ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';

--8
INSERT INTO countries(country_name, region_id, population)
VALUES(DEFAULT, 5, 20000000);

--9
INSERT INTO countries
VALUES(DEFAULT);

--10
CREATE TABLE countries_new( LIKE countries);

--11
INSERT INTO countries_new
SELECT *
FROM countries;

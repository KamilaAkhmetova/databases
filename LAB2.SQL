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

--12
UPDATE countries_new
SET region_id = 1 WHERE region_id IS NULL;

--13
UPDATE countries_new
SET population = 0.1 * population + population
RETURNING country_name, population AS "New Population";

--14
DELETE FROM countries
WHERE population < 100000;

--15
DELETE FROM countries_new
USING countries
WHERE countries.country_id = countries_new.country_id
RETURNING countries_new.*;

--16
DELETE FROM countries
RETURNING countries.*;


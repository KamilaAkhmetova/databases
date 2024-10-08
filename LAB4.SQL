--1
CREATE DATABASE lab4;
--2
CREATE TABLE Warehouses(
    code int,
    location CHAR(255),
    capacity int
);
CREATE TABLE Boxes(
    code CHAR(4),
    contents CHAR(255),
    value REAL,
    warehouse INT
);
--3
INSERT INTO Warehouses(code,location, capacity) VALUES(1, 'Chicago', 3);
INSERT INTO Warehouses(code,location, capacity) VALUES(2, 'Chicago', 4);
INSERT INTO Warehouses(code,location, capacity) VALUES(3, 'New York', 7 );
INSERT INTO Warehouses(code,location, capacity) VALUES(4, 'Los Angeles', 2);
INSERT INTO Warehouses(code,location, capacity) VALUES(5, 'San Francisco', 8);

SELECT * FROM Warehouses;

INSERT INTO Boxes(code,contents, value, warehouse ) VALUES('0MN7', 'Rocks', 180, 3);
INSERT INTO Boxes(code,contents, value, warehouse ) VALUES('4H8P', 'Rocks', 250, 1);
INSERT INTO Boxes(code,contents, value, warehouse ) VALUES('4RT3', 'Scissors', 190, 4);
INSERT INTO Boxes(code,contents, value, warehouse ) VALUES('7G3H', 'Rocks', 200, 1);
INSERT INTO Boxes(code,contents, value, warehouse ) VALUES('8JN6', 'Papers', 75, 1);
INSERT INTO Boxes(code,contents, value, warehouse ) VALUES('8Y6U', 'Papers', 50, 3);
INSERT INTO Boxes(code,contents, value, warehouse ) VALUES('9J6F', 'Papers',175, 2);
INSERT INTO Boxes(code,contents, value, warehouse ) VALUES('LL08', 'Rocks', 140, 4);
INSERT INTO Boxes(code,contents, value, warehouse ) VALUES('P0H6', 'Scissors', 125, 1);
INSERT INTO Boxes(code,contents, value, warehouse ) VALUES('P2T6', 'Scissors', 150, 2);
INSERT INTO Boxes(code,contents, value, warehouse ) VALUES('TU55', 'Papers', 90, 5);

SELECT * FROM Boxes;

--4
SELECT * FROM Warehouses;

--5
SELECT * FROM Boxes
WHERE value > 150;

--6
SELECT DISTINCT ON (contents) *
FROM Boxes;

--7
SELECT warehouse, COUNT(1)
FROM Boxes
GROUP BY warehouse;

--8
SELECT warehouse, COUNT(1) AS num_of_boxes
FROM Boxes
GROUP BY warehouse
HAVING COUNT(1) > 2;

--9
INSERT INTO Warehouses (code, location, capacity)
VALUES ((SELECT COALESCE(MAX(code), 0) + 1 FROM Warehouses), 'New York', 3);

--10
INSERT INTO boxes(code, contents, value, warehouse)
VALUES ('H5RT', 'Paper', 200, 2);

--11
UPDATE Boxes
SET value = value * 0.85
WHERE value = (
    SELECT MAX(value)
    FROM Boxes
    WHERE value < (
        SELECT MAX(value)
        FROM Boxes
        WHERE value < (SELECT MAX(value) FROM Boxes)
    )
);

--12
DELETE FROM Boxes
WHERE value < 150;

--13
DELETE FROM Boxes
WHERE warehouse IN (SELECT code FROM Warehouses WHERE location = 'New York')
RETURNING *;

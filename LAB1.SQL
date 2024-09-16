--1
CREATE DATABASE lab1;
--2
CREATE TABLE users (
    id SERIAL,
    firstname VARCHAR(50),
    lastname VARCHAR(50)
);
--3
ALTER TABLE users
ADD COLUMN isadmin INT CHECK (isadmin IN (0, 1));
--3(использовала это)
ALTER TABLE users
ADD COLUMN isadmin int;
--4
ALTER TABLE users
ALTER COLUMN isadmin SET DATA TYPE BOOLEAN USING CASE WHEN isadmin=1 THEN TRUE ELSE FALSE END;
--5 
ALTER TABLE users
ALTER COLUMN isadmin SET DEFAULT false;
--6
ALTER TABLE users
ADD PRIMARY KEY (id);
--7
CREATE TABLE tasks(
    id SERIAL,
    name VARCHAR(50),
    user_id int
);
--8
DROP TABLE tasks;
--9
DROP DATABASE lab1;

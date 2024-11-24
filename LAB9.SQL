CREATE DATABASE lab9;

-- 1
CREATE FUNCTION increase_value(p1 int)
RETURNS INT AS $$
    BEGIN
    RETURN p1 + 10;
    END;
    $$
LANGUAGE plpgsql;

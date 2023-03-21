CREATE OR REPLACE FUNCTION retrieve_customers(start_num INTEGER, end_num INTEGER)
RETURNS TABLE (
    customer_id INTEGER,
    store_id INTEGER,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    email VARCHAR(50),
    address_id INTEGER,
    active BOOLEAN,
    create_date TIMESTAMP,
    last_update TIMESTAMP
) AS $$
BEGIN
    IF (start_num < 0 OR end_num < 0 OR start_num > 600 OR end_num > 600) THEN
        RAISE EXCEPTION 'Invalid start or end number';
    END IF;

    RETURN QUERY SELECT customer_id, store_id, first_name, last_name, email, address_id, active, create_date, last_update
    FROM customer
    ORDER BY address_id
    LIMIT (end_num - start_num + 1)
    OFFSET (start_num - 1);
END;
$$ LANGUAGE plpgsql;

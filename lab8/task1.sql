create function retrieves()
    returns TABLE(add character varying)
    language plpgsql
as
$$
BEGIN
    return query 
        SELECT address from address WHERE address.address LIKE '%11%'
                    and address.city_id >=400 and address.city_id<=600;
END;
$$;
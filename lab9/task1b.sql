ALTER TABLE accounts
ADD COLUMN bank_name VARCHAR(255),
ADD COLUMN internal_fee NUMERIC(10, 2) DEFAULT 0,
ADD COLUMN external_fee NUMERIC(10, 2) DEFAULT 30;


UPDATE accounts
SET bank_name = 'SberBank'
WHERE id IN (1, 3);

UPDATE accounts
SET bank_name = 'Tinkoff'
WHERE id = 2;


CREATE OR REPLACE FUNCTION calculate_fee(
    sender_bank VARCHAR(255),
    receiver_bank VARCHAR(255),
    amount NUMERIC(10, 2)
)
RETURNS NUMERIC(10, 2) AS $$
BEGIN
    IF sender_bank = receiver_bank THEN
        RETURN 0.00;
    ELSE
        RETURN 30.00;
    END IF;
END;
$$ LANGUAGE plpgsql;


BEGIN;
SAVEPOINT first_p;
UPDATE accounts
SET credit = credit - 500.00
WHERE id = 1;

UPDATE accounts
SET credit = credit + 500.00
WHERE id = 3;


UPDATE accounts
SET internal_fee = internal_fee + calculate_fee('SberBank', 'SberBank', 500.00)
WHERE id IN (1, 3);


BEGIN;
SAVEPOINT t2_savepoint;
UPDATE accounts
SET credit = credit - 700.00
WHERE id = 2;

UPDATE accounts
SET credit = credit + 700.00
WHERE id = 1;

UPDATE accounts
SET internal_fee = internal_fee + calculate_fee('Tinkoff', 'SberBank', 700.00),
    external_fee = external_fee + calculate_fee('Tinkoff', 'SberBank', 700.00)
WHERE id IN (1, 2);



BEGIN;
SAVEPOINT t3_savepoint;
UPDATE accounts
SET credit = credit - 100.00
WHERE id = 2;

UPDATE accounts
SET credit = credit + 100.00
WHERE id = 3;

UPDATE accounts
SET internal_fee = internal_fee + calculate_fee('Tinkoff', 'SberBank', 100.00),
    external_fee = external_fee + calculate_fee('Tinkoff', 'SberBank', 100.00)
WHERE id IN (2, 3);


SELECT *, internal_fee + external_fee AS total_fee FROM accounts;


ROLLBACK TO first_p;

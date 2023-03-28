CREATE TABLE Ledger (
    id SERIAL PRIMARY KEY,
    from_account_id INTEGER REFERENCES accounts(id),
    to_account_id INTEGER REFERENCES accounts(id),
    fee NUMERIC(10, 2) DEFAULT 0,
    amount NUMERIC(10, 2) NOT NULL,
    transaction_datetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO accounts (name, credit, currency, bank_name)
VALUES ('Account 1', 1000.00, 'Rub', 'SberBank'),
       ('Account 2', 1000.00, 'Rub', 'Tinkoff'),
       ('Account 3', 1000.00, 'Rub', 'SberBank');


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
SAVEPOINT t1_savepoint;
INSERT INTO Ledger (from_account_id, to_account_id, fee, amount)
VALUES (1, 3, calculate_fee('SberBank', 'SberBank', 500.00), 500.00);

UPDATE accounts
SET credit = credit - 500.00
WHERE id = 1;

UPDATE accounts
SET credit = credit + 500.00
WHERE id = 3;


UPDATE accounts
SET internal_fee = internal_fee + calculate_fee('SberBank', 'SberBank', 500.00)
WHERE id IN (1, 3);

COMMIT;

BEGIN;
SAVEPOINT t2_savepoint;
INSERT INTO Ledger (from_account_id, to_account_id, fee, amount)
VALUES (2, 1, calculate_fee('Tinkoff', 'SberBank', 700.00), 700.00);

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

COMMIT;

BEGIN;
SAVEPOINT t3_savepoint;
INSERT INTO Ledger (from_account_id, to_account_id, fee, amount)
VALUES (2, 3, calculate_fee('Tinkoff', 'SberBank', 100.00), 100.00);

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

COMMIT;


SELECT *, internal_fee + external_fee AS total_fee FROM accounts;


SELECT * FROM Ledger;

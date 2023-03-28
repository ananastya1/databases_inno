CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    credit NUMERIC(10, 2),
    currency VARCHAR(3)
);

INSERT INTO accounts (name, credit, currency)
VALUES ('John Smith', 1000.00, 'RUB');

INSERT INTO accounts (name, credit, currency)
VALUES ('Jane Doe', 1000.00, 'RUB');

INSERT INTO accounts (name, credit, currency)
VALUES ('Sarah Lee', 1000.00, 'RUB');

BEGIN;

SAVEPOINT t1_savepoint;
UPDATE accounts
SET credit = credit - 500.00
WHERE id = 1;

UPDATE accounts
SET credit = credit + 500.00
WHERE id = 3;


SAVEPOINT t2_savepoint;
UPDATE accounts
SET credit = credit - 700.00
WHERE id = 2;

UPDATE accounts
SET credit = credit + 700.00
WHERE id = 1;


SAVEPOINT t3_savepoint;
UPDATE accounts
SET credit = credit - 100.00
WHERE id = 2;

UPDATE accounts
SET credit = credit + 100.00
WHERE id = 3;


SELECT * FROM accounts;

ROLLBACK TO t1_savepoint;




CREATE TABLE IF NOT EXISTS account2
(
    username character varying,
    fullname character varying,
    balance integer,
    group_id integer
);

INSERT INTO account2(username, fullname, balance, group_id)
VALUES ('jones', 'Alice Jones', 82, 1),
('bitdiddl', 'Ben Bitdiddle', 65, 1),
('mike', 'Michael Dole', 73, 2),
('alyssa', 'Alyssa P. Hacker', 79, 3),
('bbrown', 'Bob Brown', 100, 3)
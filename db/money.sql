DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE tags;


CREATE TABLE merchants (
  id serial4 PRIMARY KEY,
  merchant_name VARCHAR(255)
);

CREATE TABLE tags (
  id serial4 PRIMARY KEY,
  tag_name VARCHAR(255)
);

CREATE TABLE transactions (
  id serial4 PRIMARY KEY,
  merchant_id int4 REFERENCES merchants(id) ON DELETE CASCADE,
  tag_id int4 REFERENCES tags(id) ON DELETE CASCADE,
  price INT2,
  transaction_date DATE
);

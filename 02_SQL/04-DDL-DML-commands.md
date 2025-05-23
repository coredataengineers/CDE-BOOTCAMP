DDL (Data Definition Language) and DML (Data Manipulation Language) are two of the main categories of SQL commands. 

## DDL (Data Definition Language)
Purpose: DDL commands are used to create, modify, and delete the structure of your database objects. They deal with the schema of your database.

Key Characteristics:
- They affect the structure, not the data within the structure.
- They are auto-committed, meaning changes are immediately and permanently saved to the database; you cannot roll them back.

#### Common DDL Commands:
##### CREATE: Used to create new database objects.
- CREATE DATABASE: Creates a new database.
- CREATE TABLE: Creates a new table within a database.
- CREATE INDEX: Creates an index on a table to improve query performance.
- CREATE VIEW: Creates a virtual table based on the result set of a SQL query.
- CREATE PROCEDURE/FUNCTION: Creates stored procedures or functions.

#### CREATE TABLE statement
```sql
CREATE TABLE orders (      -- create orders table
	id integer,
	account_id integer,
	occurred_at timestamp,
	standard_qty integer,
	gloss_qty integer,
	poster_qty integer,
	total integer
);

CREATE TABLE employees (      -- create employees table 
    emp_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dept_id INT,
    salary DECIMAL(10,2) CHECK (salary > 0),
    hire_date DATE DEFAULT CURRENT_DATE
);
```

### Constraints Deep Dive
| Constraint       | Purpose                          | Example                          |
|------------------|----------------------------------|----------------------------------|
| `PRIMARY KEY`    | Uniquely identifies rows         | `id INT PRIMARY KEY`            |
| `FOREIGN KEY`    | Enforces relational integrity    | `dept_id INT REFERENCES depts`  |
| `UNIQUE`         | Allows only distinct values      | `email VARCHAR(255) UNIQUE`     |
| `CHECK`          | Custom validation rules          | `age INT CHECK (age >= 18)`     |
| `DEFAULT`        | Automatic value when unspecified | `created_at TIMESTAMP DEFAULT NOW()` |

#### ALTER: Used to modify the structure of existing database objects.
- ALTER TABLE table_name ADD column_name: Adds a new column to a table.
- ALTER TABLE table_name DROP column_name: Deletes a column from a table.
- ALTER TABLE  table_name MODIFY column_name: Changes the data type or constraints of an existing column.

##### ALTER TABLE Patterns
```sql
-- Add/drop columns
ALTER TABLE Customers ADD Email VARCHAR(100);
ALTER TABLE users DROP COLUMN legacy_password;

-- Change data types (caution: data conversion issues)
ALTER TABLE transactions ALTER COLUMN amount TYPE NUMERIC(12,2);
```
#### DROP: Used to delete existing database objects.
- DROP DATABASE: Deletes an entire database.
- DROP TABLE: Deletes an entire table (structure and all its data).
- DROP INDEX: Deletes an index.

##### Table Cleanup
```sql
-- Fast deletion (DDL, auto-committed)
TRUNCATE TABLE temp_logs;  

-- Conditional removal (DML, can rollback)
DELETE FROM audit_log WHERE year < 2020;

-- Full removal (irreversible)
DROP TABLE obsolete_data CASCADE;
```

#### TRUNCATE: Used to remove all records from a table, but it keeps the table structure. 
- It's faster and uses less undo space than DELETE
- For removing all rows because it's a DDL operation (not DML) and logs less.
- It cannot be rolled back.
  
```sql
truncate table table_name;

truncate table orders; 
```



## DML (Data Manipulation Language)
Purpose: DML commands are used to manage and manipulate data within the database objects. They interact with the actual records.

Key Characteristics:

- They affect the data stored in the tables.
- They are not auto-committed and can be rolled back (undone) if necessary, often within a transaction.

#### Common DML Commands:

- `SELECT:` Used to retrieve data from one or more tables. This is the most frequently used DML command.
- `INSERT:` Used to add new rows (records) of data into a table.
- `UPDATE:` Used to modify existing data within a table.
- `DELETE:` Used to remove one or more rows (records) from a table.

## Advanced Data Operations
### INSERT Variants
```sql
-- CTAS (Create Table As Select)
CREATE TABLE high_value_customers AS
SELECT * FROM customers WHERE lifetime_spend > 10000;

-- IIAS (Insert Into As Select)
-- used Bulk insert from query
INSERT INTO order_archive
SELECT * FROM orders WHERE status = 'completed';
```

### UPDATE with JOIN
```sql
UPDATE inventory i
SET stock = stock - o.quantity
FROM orders o
WHERE i.product_id = o.product_id
AND o.order_date > CURRENT_DATE - INTERVAL '7 days';
```

### MERGE/UPSERT
```sql
-- Standard MERGE (SQL:2003)
MERGE INTO customer_metrics t
USING daily_stats s
ON t.customer_id = s.customer_id
WHEN MATCHED THEN
    UPDATE SET visits = t.visits + s.visits
WHEN NOT MATCHED THEN
    INSERT (customer_id, visits) VALUES (s.customer_id, s.visits);
```

## Transaction Control
### ACID Properties
```sql
BEGIN;  -- Start transaction
UPDATE accounts SET balance = balance - 100 WHERE id = 123;
UPDATE accounts SET balance = balance + 100 WHERE id = 456;
COMMIT; -- OR ROLLBACK if errors occur
```

| Property   | Guarantee                              | Implementation Example              |
|------------|----------------------------------------|-------------------------------------|
| Atomicity  | All-or-nothing execution               | `ROLLBACK` on failed transfer       |
| Consistency | Valid state transitions               | `CHECK` constraints prevent invalid data |
| Isolation  | Concurrent transactions don't interfere | `BEGIN ISOLATION LEVEL SERIALIZABLE`|
| Durability | Committed changes survive crashes      | Write-ahead logging (WAL)           |

## Performance Considerations
### Index Strategies
```sql
-- Create optimized indexes
CREATE INDEX idx_orders_date ON orders(order_date DESC);
CREATE UNIQUE INDEX idx_products_sku ON products(sku);

-- Partial indexes
CREATE INDEX idx_active_users ON users(email) WHERE is_active;
```

### Index Tradeoffs
| Scenario               | Recommended Index Approach          |
|------------------------|-------------------------------------|
| Frequent exact matches | B-tree on filtered column          |
| Range queries          | BRIN for temporal data             |
| Text search            | GIN/GIST for full-text search      |
| Composite conditions   | Multi-column indexes               |

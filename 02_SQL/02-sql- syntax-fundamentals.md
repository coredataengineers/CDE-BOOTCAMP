## SQL Syntax Fundamentals
SQL follows a declarative syntax pattern:

```sql
SELECT DISTINCT/columns_names/aggregations 
FROM table_name
[WHERE conditions]
[GROUP BY groupings]
[HAVING aggregate_conditions] 
[ORDER BY sort_columns]
[LIMIT row_count];
```

Key syntax rules:
- **Case Insensitive**: `SELECT` ≡ `select` (but conventions use uppercase for keywords)
- **Termination**: Semicolon `;` ends statements (required in most DBMS)
- **Whitespace**: Insensitive to spaces/tabs/newlines
- **Comments out**: 
  ```sql
  -- Single line comment
  /* Multi-line
     comment */
  ```

## Data Types in SQL

| Category       | Common Types               | Description                          | Example Values           |
|----------------|----------------------------|--------------------------------------|--------------------------|
| **Numeric**    | `INT`, `BIGINT`, `DECIMAL` | Whole and decimal numbers            | `42`, `3.14159`          |
| **Character**  | `VARCHAR(n)`, `CHAR(n)`    | Text with variable/fixed length      | `'SQL'`, `'X'`           |
| **Temporal**   | `DATE`, `TIMESTAMP`        | Dates and precise timestamps         | `'2025-05-23'`, `NOW()`  |
| **Boolean**    | `BOOLEAN`                  | True/false values                    | `TRUE`, `FALSE`, `NULL`  |


*Note: Type availability varies by database system*

## Basic SQL Commands

### SELECT (Retrieves Data)
```sql
-- Basic form
SELECT column1, column2 FROM table_name;

-- Selecting all columns
SELECT * FROM employees;

-- Calculations
SELECT product, price * quantity AS total_value FROM orders;
```

### INSERT (Adds Data into the existing table)
```sql
-- Specify columns
INSERT INTO customers (name, email) 
VALUES ('John Doe', 'john@example.com');

-- Insert multiple rows
INSERT INTO products (id, name, price) VALUES
(1, 'Laptop', 999.99),
(2, 'Mouse', 24.95);
```

### UPDATE (Modify Data)
```sql
-- Single column update
UPDATE inventory SET stock = 50 WHERE product_id = 101;

```

### DELETE (Remove Data)
```sql
-- With condition
DELETE FROM logs WHERE created_at < '2025-01-01';

-- WARNING! Unconditional delete
DELETE FROM temp_data;  -- Removes ALL rows
```

## Filtering with WHERE Clause

```sql
-- Basic comparisons
SELECT * FROM products WHERE price > 100;

-- Multiple conditions
SELECT name FROM employees 
WHERE department = 'Sales' AND hire_date > '2024-01-01';

-- Pattern matching
SELECT * FROM contacts 
WHERE email LIKE '%@gmail.com';

-- NULL handling
SELECT * FROM orders 
WHERE ship_date IS NULL;
```

Common WHERE operators:
- `=`, `<>`/`!=` (equality)
- `>`, `<`, `>=`, `<=` (comparison)
- `BETWEEN` (range)
- `IN` (value list)
- `LIKE` (pattern)
- `IS [NOT] NULL` (null checks)
- `AND`, `OR`

## Sorting with ORDER BY

```sql
-- Single column sort
SELECT * FROM products ORDER BY price DESC;

-- Multi-column sort
SELECT first_name, last_name FROM employees
ORDER BY department ASC, hire_date DESC;

-- Using column positions
SELECT name, price, stock FROM inventory
ORDER BY 2 DESC, 3 ASC;  -- Sorts by price then stock
```

## Limiting Results

```sql
-- MySQL/PostgreSQL/SQLite
SELECT * FROM table_name LIMIT 10;

-- SQL Server
SELECT TOP 10 * FROM table_name;

-- Oracle
SELECT * FROM table_name
FETCH FIRST 10 ROWS ONLY;
```

Performance Tip: Always use `ORDER BY` with `LIMIT` for predictable results!

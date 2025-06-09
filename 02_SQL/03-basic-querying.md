## Selecting Specific Columns

```sql
-- Select single column
SELECT product_name FROM products;

-- Select multiple columns
SELECT id, name, price FROM products;

-- Column aliases
SELECT 
    username AS "User Name",
    signup_date AS "Member Since"
FROM users;
```

**Best Practices**:
- Avoid `SELECT *` in production code
- Use AS for calculated columns or clearer naming

## Using DISTINCT for Unique Values

```sql
-- Basic distinct
SELECT DISTINCT department   -- removes duplicates
FROM employees;

-- Multi-column distinct
SELECT DISTINCT city, state
FROM customers;

-- using DISTINCT with counts (advanced)
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_id) AS unique_products 
FROM orders;
```

*Note: DISTINCT applies to the entire row, not just the first column*

## Comparison Operators

| Operator | Meaning                  | Example Usage                      |
|----------|--------------------------|------------------------------------|
| `=`      | Equal                    | `WHERE age = 25`                   |
| `<>`     | Not equal                | `WHERE status <> 'inactive'`       |
| `>`      | Greater than             | `WHERE price > 100`                |
| `<`      | Less than                | `WHERE created_at < '2025-01-01'`  |
| `>=`     | Greater or equal         | `WHERE quantity >= 10`             |
| `<=`     | Less or equal            | `WHERE rating <= 5`                |

```sql
-- Combined example
SELECT order_id 
FROM orders 
WHERE total_amount > 500 
  AND order_date <= CURRENT_DATE - INTERVAL '30 days';
```

## Logical Operators

- `LIKE:` This allows you to perform operations similar to using WHERE and =, but for cases when you might not know exactly what you are looking for.

- `IN:` This allows you to perform operations similar to using WHERE and =, but for more than one condition.

- `NOT:` This is used with IN and LIKE to select all of the rows NOT LIKE or NOT IN a certain condition.

- `AND & BETWEEN:` These allow you to combine operations where all combined conditions must be true.

- `OR:` This allows you to combine operations where at least one of the combined conditions must be true.

### AND (All conditions must be true)
```sql
SELECT * FROM inventory
WHERE warehouse = 'NYC' 
  AND quantity > 50 
  AND last_restock > '2025-04-01';

-- AND and BTEWEEN
SELECT *
FROM order
WHERE order_date BETWEEN '2016-01-01' AND '2017-01-01';
```

### OR (Any condition can be true)
```sql
SELECT name FROM employees
WHERE department = 'Sales' 
   OR department = 'Marketing';
```

### NOT (Inverse condition)
```sql
SELECT * FROM customers
WHERE NOT (status = 'VIP' OR total_purchases > 1000);
```

## Special Condition Operators

### BETWEEN (Range inclusion)
```sql
-- Numeric range
SELECT * FROM products
WHERE price BETWEEN 50 AND 100;

-- Date range
SELECT * FROM events
WHERE event_date BETWEEN '2025-06-01' AND '2025-06-30';
```

### IN (Value list matching)
```sql
-- Literal values
SELECT * FROM countries
WHERE region IN ('Europe', 'Asia', 'Africa');

-- Subquery
SELECT name FROM products
WHERE category_id IN (
    SELECT id FROM categories 
    WHERE type = 'Electronics'
);
```

### LIKE (Pattern matching)
```sql
-- % = any sequence, _ = single character
SELECT * FROM contacts
WHERE phone LIKE '234-___-____';  -- NG area code

SELECT name
FROM accounts
WHERE name LIKE 'C%';   --- returns all the names that start with the letter 'C'

```

Common patterns:
- `'abc%'` - Starts with "abc"
- `'%xyz'` - Ends with "xyz"
- `'%123%'` - Contains "123"
- `'_b%'` - Second character is "b"

## NULL Handling

```sql
-- Find missing data
SELECT student_id FROM grades
WHERE test_score IS NULL;

-- Exclude nulls
SELECT * FROM employees
WHERE manager_id IS NOT NULL;
```

**Critical Behaviors**:
- `NULL = NULL` → NULL (not TRUE)
- `NULL AND TRUE` → NULL
- Use `COALESCE()` for default values:
  ```sql
  SELECT name, COALESCE(bio, 'No biography') FROM authors;
  ```

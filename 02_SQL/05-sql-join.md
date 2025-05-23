## 🔗 Join Types

### INNER JOIN (Default)
```sql
-- Basic equijoin
SELECT u.username, o.order_date
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id;

-- With additional filters
SELECT p.name, oi.quantity
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
WHERE oi.quantity > 5;
```

### OUTER JOINS
#### LEFT JOIN
```sql
-- All users + their orders (if any)
SELECT u.username, COUNT(o.order_id) AS order_count
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.username;
```

#### FULL OUTER JOIN
```sql
-- All relationships including orphans
SELECT u.username, o.order_id
FROM users u
FULL OUTER JOIN orders o ON u.user_id = o.user_id
WHERE u.user_id IS NULL OR o.order_id IS NULL;
```

### Specialized Joins
#### CROSS JOIN
```sql
-- Generate all combinations
SELECT s.size, c.color
FROM sizes s
CROSS JOIN colors c;
```

#### SELF JOIN
```sql
-- Employee hierarchy
SELECT e.name AS employee, m.name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;
```

![image](https://github.com/user-attachments/assets/c23dd7dc-4944-42a6-bc1b-3a667fc46e04)




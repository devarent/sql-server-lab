USE LabDB;
GO

INSERT INTO dbo.customers (name, country) VALUES (N'Ada Lovelace', 'GB');
INSERT INTO dbo.customers (name, country) VALUES (N'Grace Hopper', 'US');
INSERT INTO dbo.customers (name, country) VALUES (N'Edsger Dijkstra', 'NL');

INSERT INTO dbo.orders (customer_id, total) VALUES (1, 120.50);
INSERT INTO dbo.orders (customer_id, total) VALUES (1, 80.00);
INSERT INTO dbo.orders (customer_id, total) VALUES (2, 240.00);

SELECT TOP (10) c.name, COUNT(*) AS orders, SUM(o.total) AS revenue
FROM dbo.customers c
JOIN dbo.orders o ON o.customer_id = c.id
GROUP BY c.name
ORDER BY revenue DESC;

WITH ranked AS (
    SELECT c.name, o.total,
           ROW_NUMBER() OVER (PARTITION BY c.id ORDER BY o.total DESC) AS rn
    FROM dbo.customers c
    JOIN dbo.orders o ON o.customer_id = c.id
)
SELECT name, total FROM ranked WHERE rn = 1;

MERGE dbo.customers AS target
USING (SELECT N'Ada Lovelace' AS name, 'GB' AS country) AS source
ON target.name = source.name
WHEN MATCHED THEN UPDATE SET country = source.country
WHEN NOT MATCHED THEN INSERT (name, country) VALUES (source.name, source.country);

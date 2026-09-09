/*==========================================================
    CTE Queries TASK 1
==========================================================*/
WITH total_orders AS
(
    SELECT
        customer_id,
        COUNT(*) AS total_orders
    FROM orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_orders
FROM total_orders;
/*==========================================================
    CTE Queries TASK 2
==========================================================*/
WITH supplier_products AS
(
    SELECT
        supplier_id,
        COUNT(*) AS total_products,
        AVG(price) AS average_price
    FROM products
    GROUP BY supplier_id
)
SELECT
    supplier_id,
    total_products,
    average_price
FROM supplier_products;
/*==========================================================
    CTE Queries TASK 3
==========================================================*/
/*==========================================================
    CTE Queries
==========================================================*/

WITH customer_orders AS
(
    SELECT
        customer_id,
        COUNT(*) AS total_orders,
        SUM(total_amount) AS total_amount_spent
    FROM orders
    GROUP BY customer_id
)

SELECT
    customer_id,
    total_orders,
    total_amount_spent
FROM customer_orders;
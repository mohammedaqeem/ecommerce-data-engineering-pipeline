/*==========================================================
    GROUP BY Queries
==========================================================*/

SELECT
    category_id,
    COUNT(*) AS total_products
FROM products
GROUP BY category_id;
/*==========================================================
    GROUP BY Queries
==========================================================*/

SELECT 
      customer_id,
      COUNT(*) AS  total_orders,
      SUM(total_amount) AS total_amount_spent
FROM orders
GROUP BY  customer_id;

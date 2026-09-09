/*==========================================================
    Subquery Queries TASK 1
==========================================================*/
SELECT 
     product_id,
     product_name,
     price
FROM products
WHERE price>(
       SELECT AVG(price)
       FROM products
);
/*==========================================================
    Subquery Queries TASK 2
==========================================================*/
SELECT 
      customer_id,
      customer_name
FROM coustomer
WHERE customer_id IN (
            SELECT customer_id
            FROM orders
);
               
/*==========================================================
    Subquery Queries TASK 3
==========================================================*/
SELECT 
      order_id,
      customer_id,
      total_amount
FROM orders
WHERE total_amount > (
                SELECT AVG (total_amount)
                FROM orders
);
/*==========================================================
    VIEW Queries TASK 1
==========================================================*/
CREATE VIEW high_price_products AS 
SELECT
       product_id,
       product_name,
       price
FROM products
WHERE price >= 50000;
/*==========================================================
    VIEW Queries TASK 2
==========================================================*/
CREATE VIEW customer_order_summary AS
SELECT 
     coustomer. customer_id,
      coustomer.customer_name,
      orders.order_id,
      orders.order_date,
      orders.total_amount
FROM orders
INNER JOIN coustomer
     ON orders.customer_id = coustomer.customer_id;
/*==========================================================
    VIEW Queries TASK 3
==========================================================*/
CREATE VIEW supplier_product_summary AS
SELECT  
     suppliers.supplier_id,
     suppliers.supplier_name,
     products.product_id,
     products.product_name,
     products.price
FROM products 
INNER JOIN  suppliers
          ON products.supplier_id = suppliers.supplier_id;
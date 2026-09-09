/*==========================================================
    INNER JOIN Queries 1
==========================================================*/
SELECT coustomer.customer_name,
       orders.order_id,
       orders.order_date,
       orders.total_amount,
       orders.payment_status
FROM orders
INNER JOIN  coustomer
         ON orders.customer_id = coustomer.customer_id;
/*==========================================================
    INNER JOIN Queries 2
==========================================================*/
SELECT coustomer.customer_name,
       products.product_name,
       order_items.quantity,
       order_items.unit_price,
       order_items.total_price
FROM order_items
INNER JOIN orders
           ON order_items.order_id = orders.order_id
INNER JOIN coustomer
           ON orders.customer_id = coustomer.customer_id
INNER JOIN products
           ON order_items.product_id = products.product_id;
/*==========================================================
    INNER JOIN Queries 3
==========================================================*/
SELECT
    orders.order_id,
    customer.customer_name,
    products.product_name,
    categories.category_name,
    suppliers.supplier_name,
    order_items.quantity,
    order_items.total_price
FROM orders
INNER JOIN customer
    ON orders.customer_id = customer.customer_id
INNER JOIN order_items
    ON orders.order_id = order_items.order_id
INNER JOIN products
    ON order_items.product_id = products.product_id
INNER JOIN categories
    ON products.category_id = categories.category_id
INNER JOIN suppliers
    ON products.supplier_id = suppliers.supplier_id;

/*==========================================================
    LEFT JOIN Queries1
==========================================================*/
SELECT  coustomer.customer_id,
        coustomer.customer_name,
       orders.order_id,
        orders.order_date,
       orders.order_status
FROM coustomer
LEFT JOIN orders
        ON orders.customer_id = coustomer.customer_id;
/*==========================================================
    RIGHT JOIN Queries1
==========================================================*/
SELECT  coustomer.customer_name,
        orders.order_id,
        orders.order_date,
        payments.payment_id,
        payments.payment_method,
        payments.payment_status
FROM coustomer
RIGHT JOIN orders
          ON coustomer.customer_id = orders.customer_id
RIGHT JOIN payments
          ON orders.order_id = payments.order_id;

/*==========================================================
    RIGHT JOIN Queries 2
==========================================================*/
SELECT
    coustomer.customer_name,
    orders.order_id,
    payments.payment_method,
    payments.payment_amount,
    shipments.shipment_status
FROM coustomer
INNER JOIN orders
    ON coustomer.customer_id = orders.customer_id
LEFT JOIN payments
    ON orders.order_id = payments.order_id
LEFT JOIN shipments
    ON orders.order_id = shipments.order_id;
 /*==========================================================
    GROUP BY Queries
==========================================================*/

SELECT
    category_id,
    COUNT(*) AS total_products
FROM products
GROUP BY category_id;


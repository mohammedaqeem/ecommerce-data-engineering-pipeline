/*==========================================================
    REPORT Task 1 : Customer Order Summary
==========================================================*/
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_amount_spent
FROM coustomer c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name;
    /*==========================================================
    REPORT Task 2 : Product Sales Report
==========================================================*/

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.total_price) AS total_sales
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name;
    /*==========================================================
    REPORT Task 3 : Category Sales Report
==========================================================*/

SELECT
    c.category_id,
    c.category_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.total_price) AS total_sales
FROM categories c
INNER JOIN products p
    ON c.category_id = p.category_id
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    c.category_id,
    c.category_name;
    /*==========================================================
    REPORT Task 4 : Supplier Performance Report
==========================================================*/

SELECT
    s.supplier_id,
    s.supplier_name,
    COUNT(p.product_id) AS total_products,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.total_price) AS total_sales
FROM suppliers s
INNER JOIN products p
    ON s.supplier_id = p.supplier_id
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    s.supplier_id,
    s.supplier_name;
    /*==========================================================
    REPORT Task 5 : Monthly Sales Report
==========================================================*/

SELECT
    YEAR(order_date) AS sales_year,
    MONTH(order_date) AS sales_month,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_sales
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    sales_year,
    sales_month;
    /*==========================================================
    REPORT Task 6 : Top 5 Customers Report
==========================================================*/

SELECT TOP 5
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_amount_spent
FROM coustomer c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY
    total_amount_spent DESC;
    /*==========================================================
    REPORT Task 7 : Top 5 Best Selling Products Report
==========================================================*/

SELECT TOP 5
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.total_price) AS total_sales
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY
    total_quantity_sold DESC;
    /*==========================================================
    REPORT Task 8 : Payment Status Report
==========================================================*/

SELECT
    payment_status,
    COUNT(payment_id) AS total_payments,
    SUM(payment_amount) AS total_payment_amount
FROM payments
GROUP BY
    payment_status
ORDER BY
    total_payment_amount DESC;
    /*==========================================================
    REPORT Task 9 : Shipment Status Report
==========================================================*/

SELECT
    shipment_status,
    COUNT(shipment_id) AS total_shipments
FROM shipments
GROUP BY
    shipment_status
ORDER BY
    total_shipments DESC;
    /*==========================================================
    REPORT Task 10 : Customer Returns Report
==========================================================*/

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(r.return_id) AS total_returns,
    SUM(r.refund_amount) AS total_refund_amount
FROM coustomer c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN returns r
    ON o.order_id = r.order_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY
    total_refund_amount DESC;
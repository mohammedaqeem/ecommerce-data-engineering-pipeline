/*==========================================================
    PHASE 5 — ETL VALIDATION
    TASK 1 — ROW COUNT VALIDATION
==========================================================*/
 1. Customers 

SELECT COUNT(*) AS source_customers
FROM coustomer;

SELECT COUNT(*) AS warehouse_customers
FROM dim_customers;

 2. Categories 

SELECT COUNT(*) AS source_categories
FROM categories;

SELECT COUNT(*) AS warehouse_categories
FROM dim_categories;

 3. Suppliers 

SELECT COUNT(*) AS source_suppliers
FROM suppliers;

SELECT COUNT(*) AS warehouse_suppliers
FROM dim_suppliers;

 4. Products 

SELECT COUNT(*) AS source_products
FROM products;

SELECT COUNT(*) AS warehouse_products
FROM dim_products;

 5. Sales

SELECT COUNT(*) AS source_sales
FROM order_items;

SELECT COUNT(*) AS warehouse_sales
FROM fact_sales;

/*==========================================================
    TASK 2 — DUPLICATE VALIDATION
==========================================================*/


 1. Duplicate Customers 

SELECT
    customer_id,
    COUNT(*) AS record_count
FROM dim_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;


2. Duplicate Categories 

SELECT
    category_id,
    COUNT(*) AS record_count
FROM dim_categories
GROUP BY category_id
HAVING COUNT(*) > 1;


3. Duplicate Suppliers 

SELECT
    supplier_id,
    COUNT(*) AS record_count
FROM dim_suppliers
GROUP BY supplier_id
HAVING COUNT(*) > 1;


 4. Duplicate Products 

SELECT
    product_id,
    COUNT(*) AS record_count
FROM dim_products
GROUP BY product_id
HAVING COUNT(*) > 1;


 5. Duplicate Sales 

SELECT
    order_id,
    product_key,
    COUNT(*) AS record_count
FROM fact_sales
GROUP BY order_id, product_key
HAVING COUNT(*) > 1;

/*==========================================================
    TASK 4 — SALES AMOUNT VALIDATION
==========================================================*/

SELECT
    oi.order_id,
    oi.product_id,
    oi.total_price AS source_amount,
    fs.sales_amount AS warehouse_amount
FROM order_items oi
INNER JOIN fact_sales fs
    ON oi.order_id = fs.order_id
INNER JOIN dim_products dp
    ON fs.product_key = dp.product_key
   AND oi.product_id = dp.product_id
WHERE oi.total_price <> fs.sales_amount;

/*==========================================================
    TASK 5 — NULL VALIDATION
==========================================================*/

SELECT
    COUNT(*) AS null_order_id
FROM fact_sales
WHERE order_id IS NULL;


SELECT
    COUNT(*) AS null_customer_key
FROM fact_sales
WHERE customer_key IS NULL;


SELECT
    COUNT(*) AS null_product_key
FROM fact_sales
WHERE product_key IS NULL;


SELECT
    COUNT(*) AS null_category_key
FROM fact_sales
WHERE category_key IS NULL;


SELECT
    COUNT(*) AS null_supplier_key
FROM fact_sales
WHERE supplier_key IS NULL;


SELECT
    COUNT(*) AS null_order_date
FROM fact_sales
WHERE order_date IS NULL;


SELECT
    COUNT(*) AS null_quantity
FROM fact_sales
WHERE quantity IS NULL;


SELECT
    COUNT(*) AS null_sales_amount
FROM fact_sales
WHERE sales_amount IS NULL;
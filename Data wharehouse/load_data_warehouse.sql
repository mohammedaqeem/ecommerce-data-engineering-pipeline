/*==========================================================
    LOAD CUSTOMERS INTO DATA WAREHOUSE
==========================================================*/
INSERT INTO dim_customers
(
    customer_id,
    customer_name,
    email,
    city,
    state,
    country
)
SELECT
    customer_id,
    customer_name,
    email,
    city,
    state,
    country
FROM coustomer;

/*==========================================================
    LOAD CATEGORIES INTO DATA WAREHOUSE
==========================================================*/
INSERT INTO dim_categories
(
    category_id,
    category_name
)
SELECT
    category_id,
    category_name
FROM categories;
/*==========================================================
    LOAD SUPPLIERS INTO DATA WAREHOUSE
==========================================================*/
INSERT INTO dim_suppliers
(
    supplier_id,
    supplier_name,
    contact_person,
    email,
    phone,
    city,
    country,
    created_date
)
SELECT
    supplier_id,
    supplier_name,
    contact_person,
    email,
    phone,
    city,
    country,
    created_date
FROM suppliers;
/*==========================================================
    LOAD PRODUCTS INTO DATA WAREHOUSE
==========================================================*/
INSERT INTO dim_products
(
    product_id,
    product_name,
    category_id,
    supplier_id,
    price,
    stock_quantity,
    brand,
    created_date
)
SELECT
    product_id,
    product_name,
    category_id,
    supplier_id,
    price,
    stock_quantity,
    brand,
    created_date
FROM products;
/*==========================================================
    LOAD SALES INTO FACT TABLE
==========================================================*/

INSERT INTO fact_sales
(
    order_id,
    customer_key,
    product_key,
    category_key,
    supplier_key,
    order_date,
    quantity,
    sales_amount
)
SELECT
    o.order_id,
    dc.customer_key,
    dp.product_key,
    dcat.category_key,
    ds.supplier_key,
    o.order_date,
    oi.quantity,
    oi.total_price
FROM orders o
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN dim_customers dc
    ON o.customer_id = dc.customer_id
INNER JOIN dim_products dp
    ON oi.product_id = dp.product_id
INNER JOIN dim_categories dcat
    ON dp.category_id = dcat.category_id
INNER JOIN dim_suppliers ds
    ON dp.supplier_id = ds.supplier_id;

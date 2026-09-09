/*==========================================================
     TASK1DATA WAREHOUSE
    Dimension: Customers
==========================================================*/
Create table dim_customers (
customer_key INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

/*==========================================================
    TASK2 DATA WAREHOUSE
    Dimension: Categories
==========================================================*/
Create table dim_categories (
 category_key INT IDENTITY(1,1) PRIMARY KEY,
    category_id INT,
    category_name VARCHAR(100)
);
/*==========================================================
   TASK3 DATA WAREHOUSE
    Dimension: Suppliers
==========================================================*/
CREATE TABLE dim_suppliers
(
    supplier_key INT IDENTITY(1,1) PRIMARY KEY,
    supplier_id INT,
    supplier_name VARCHAR(100),
    contact_person VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(50),
    country VARCHAR(50),
    created_date DATE
);
/*==========================================================
    TASK4 DATA WAREHOUSE
    Dimension: Products
==========================================================*/
CREATE TABLE dim_products
(
    product_key INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(100),
    category_id INT,
    supplier_id INT,
    price DECIMAL(10,2),
    stock_quantity INT,
    brand VARCHAR(100),
    created_date DATE
);

========================================================
    TASK5 DATA WAREHOUSE
    Fact: Sales
==========================================================*/

CREATE TABLE fact_sales
(
    sales_key INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    customer_key INT,
    product_key INT,
    category_key INT,
    supplier_key INT,
    order_date DATE,
    quantity INT,
    sales_amount DECIMAL(12,2)
);

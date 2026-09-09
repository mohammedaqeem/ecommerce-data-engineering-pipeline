*==========================================================
    Table 1 : customer
==========================================================*/
CREATE TABLE customer (
   customer_id INT PRIMARY KEY,
   customer_name VARCHAR(50) NOT NULL,
   email VARCHAR(100)   UNIQUE,
   phone VARCHAR(15) NOT NULL,
   city VARCHAR(50) NOT NULL,
   state VARCHAR(50) NOT NULL,
   country VARCHAR(50) NOT NULL,
   created_date DATE  NOT NULL
);
/*==========================================================
    Table 2 : categories
==========================================================*/
CREATE TABLE categories (
   category_id  INT  PRIMARY KEY,
   category_name  VARCHAR(100)  NOT NULL,
   description  VARCHAR(255) NULL
);
/*==========================================================
    Table 3 : suppliers
==========================================================*/

CREATE TABLE suppliers
(
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    created_date DATE NOT NULL
);

/*==========================================================
    Table 4 : products
==========================================================*/

CREATE TABLE products
(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    supplier_id INT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    brand VARCHAR(100) NOT NULL,
    created_date DATE NOT NULL,

    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);
/*==========================================================
    Table 5 : orders
==========================================================*/
CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE NOT NULL,
  order_status VARCHAR(30) NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL,
  payment_status VARCHAR(30) NOT NULL,
  FOREIGN KEY (  customer_id) REFERENCES coustomer(customer_id)
);

/*==========================================================
    Table 6 : order_items
==========================================================*/
CREATE TABLE order_items (
  order_item_id INT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity   INt NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  total_price DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

/*==========================================================
    Table 7 : payments
==========================================================*/
CREATE TABLE payments (
 payment_id  INT  PRIMARY KEY,
 order_id  INT, 
 payment_date  DATE  NOT NULL,
 payment_method  VARCHAR(50)  NOT NULL,
 payment_amount  DECIMAL(10,2)  NOT NULL,
 payment_status  VARCHAR(30)  NOT NULL,
 transaction_id  VARCHAR(100)  UNIQUE
 FOREIGN KEY (order_id) REFERENCES orders (order_id)
);
/*==========================================================
    Table 8 : shipments
==========================================================*/
CREATE TABLE shipments
(
    shipment_id INT PRIMARY KEY,
    order_id INT,
    shipment_date DATE NOT NULL,
    delivery_date DATE,
    shipping_address VARCHAR(255) NOT NULL,
    courier_name VARCHAR(100) NOT NULL,
    tracking_number VARCHAR(100) UNIQUE,
    shipment_status VARCHAR(30) NOT NULL,

    FOREIGN KEY (order_id) REFERENCES orders(order_id)

);
/*==========================================================
    Table 9 : returns
==========================================================*/
CREATE TABLE returns (
  return_id  INT  PRIMARY KEY,
  order_id  INT  ,
  product_id  INT  ,
  return_date  DATE  NOT NULL,
 return_reason  VARCHAR(255)  NOT NULL,
 refund_amount  DECIMAL(10,2)  NOT NULL,
 return_status  VARCHAR(30)  NOT NULL,
 FOREIGN KEY (order_id) REFERENCES orders (order_id),
 FOREIGN KEY (product_id) REFERENCES products (product_id)
);
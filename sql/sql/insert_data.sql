/*==========================================================
    Customers Data
==========================================================*/
 INSERT INTO coustomer 
 (customer_id, customer_name, email, phone, city, state, country, created_date)
 VALUES
(101, 'Samad', 'samad@gmail.com', '9876543210', 'Nizamsagar', 'Telangana', 'India', '2026-01-10'),
(102, 'Alisha', 'alisha@gmail.com', '9876543211', 'Hyderabad', 'Telangana', 'India', '2026-01-11'),
(103, 'Aban', 'aban@gmail.com', '9876543212', 'Kamareddy', 'Telangana', 'India', '2026-01-12'),
(104, 'Rahul', 'rahul@gmail.com', '9876543213', 'Mumbai', 'Maharashtra', 'India', '2026-01-13'),
(105, 'Priya', 'priya@gmail.com', '9876543214', 'Bengaluru', 'Karnataka', 'India', '2026-01-14'),
(106, 'Arjun', 'arjun@gmail.com', '9876543215', 'Chennai', 'Tamil Nadu', 'India', '2026-01-15'),
(107, 'Sneha', 'sneha@gmail.com', '9876543216', 'Pune', 'Maharashtra', 'India', '2026-01-16'),
(108, 'Amit', 'amit@gmail.com', '9876543217', 'Delhi', 'Delhi', 'India', '2026-01-17'),
(109, 'Neha', 'neha@gmail.com', '9876543218', 'Jaipur', 'Rajasthan', 'India', '2026-01-18'),
(110, 'Kiran', 'kiran@gmail.com', '9876543219', 'Vijayawada', 'Andhra Pradesh', 'India', '2026-01-19');

/*==========================================================
    Categories Data
==========================================================*/
INSERT INTO categories 
(category_id, category_name, description)
VALUES
(1, 'Electronics', 'Electronic devices and accessories'),
(2, 'Clothing', 'Men and women clothing'),
(3, 'Footwear', 'Shoes, sandals, and slippers'),
(4, 'Furniture', 'Home and office furniture'),
(5, 'Books', 'Educational and story books'),
(6, 'Groceries', 'Daily household grocery items'),
(7, 'Sports', 'Sports equipment and accessories'),
(8, 'Beauty', 'Beauty and personal care products'),
(9, 'Toys', 'Children toys and games'),
(10, 'Kitchen', 'Kitchen appliances and utensils');

/*==========================================================
    Suppliers Data
==========================================================*/
INSERT INTO suppliers
(supplier_id, supplier_name, contact_person, email, phone, city, country, created_date)
VALUES
(1, 'Tech Solutions', 'Rahul Sharma', 'techsolutions@gmail.com', '9876543210', 'Hyderabad', 'India', '2026-01-01'),
(2, 'Global Electronics', 'Amit Kumar', 'globalelectronics@gmail.com', '9876543211', 'Mumbai', 'India', '2026-01-02'),
(3, 'Fashion Hub', 'Priya Singh', 'fashionhub@gmail.com', '9876543212', 'Delhi', 'India', '2026-01-03'),
(4, 'Book World', 'Sneha Reddy', 'bookworld@gmail.com', '9876543213', 'Bengaluru', 'India', '2026-01-04'),
(5, 'Home Needs', 'Arjun Patel', 'homeneeds@gmail.com', '9876543214', 'Chennai', 'India', '2026-01-05'),
(6, 'Sports Zone', 'Kiran Rao', 'sportszone@gmail.com', '9876543215', 'Pune', 'India', '2026-01-06'),
(7, 'Kitchen Store', 'Neha Gupta', 'kitchenstore@gmail.com', '9876543216', 'Jaipur', 'India', '2026-01-07'),
(8, 'Beauty Care', 'Anjali Verma', 'beautycare@gmail.com', '9876543217', 'Kolkata', 'India', '2026-01-08'),
(9, 'Mobile Planet', 'Vikas Sharma', 'mobileplanet@gmail.com', '9876543218', 'Ahmedabad', 'India', '2026-01-09'),
(10, 'Furniture House', 'Deepak Jain', 'furniturehouse@gmail.com', '9876543219', 'Lucknow', 'India', '2026-01-10');

/*==========================================================
    Products Data
==========================================================*/
INSERT INTO products
(product_id, product_name, category_id, supplier_id, price, stock_quantity, brand, created_date)
VALUES
(101, 'Samsung Galaxy S25', 1, 1, 85000.00, 50, 'Samsung', '2026-01-01'),
(102, 'Dell Inspiron 15', 1, 2, 65000.00, 30, 'Dell', '2026-01-02'),
(103, 'Nike Running Shoes', 3, 3, 5500.00, 100, 'Nike', '2026-01-03'),
(104, 'Office Chair', 4, 5, 12000.00, 25, 'Godrej', '2026-01-04'),
(105, 'Java Programming Book', 5, 4, 800.00, 200, 'Pearson', '2026-01-05'),
(106, 'Cricket Bat', 7, 6, 3500.00, 40, 'SG', '2026-01-06'),
(107, 'Mixer Grinder', 10, 7, 4500.00, 35, 'Prestige', '2026-01-07'),
(108, 'Face Wash', 8, 8, 250.00, 150, 'Himalaya', '2026-01-08'),
(109, 'Leather Wallet', 2, 3, 1200.00, 80, 'Wildcraft', '2026-01-09'),
(110, 'Wooden Study Table', 4, 10, 15000.00, 20, 'Durian', '2026-01-10');
/*==========================================================
    Orders Data
==========================================================*/
INSERT INTO orders
(order_id, customer_id, order_date, order_status, total_amount, payment_status)
VALUES
(1, 101, '2026-02-01', 'Delivered', 85000.00, 'Paid'),
(2, 102, '2026-02-02', 'Shipped', 65000.00, 'Paid'),
(3, 103, '2026-02-03', 'Processing', 5500.00, 'Pending'),
(4, 104, '2026-02-04', 'Delivered', 12000.00, 'Paid'),
(5, 105, '2026-02-05', 'Cancelled', 800.00, 'Refunded'),
(6, 106, '2026-02-06', 'Delivered', 3500.00, 'Paid'),
(7, 107, '2026-02-07', 'Processing', 4500.00, 'Pending'),
(8, 108, '2026-02-08', 'Shipped', 250.00, 'Paid'),
(9, 109, '2026-02-09', 'Delivered', 1200.00, 'Paid'),
(10, 110, '2026-02-10', 'Processing', 15000.00, 'Pending');
/*==========================================================
    Order Items Data
==========================================================*/
INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, unit_price, total_price)
VALUES
(1, 1, 101, 1, 85000.00, 85000.00),
(2, 2, 102, 1, 65000.00, 65000.00),
(3, 3, 103, 2, 5500.00, 11000.00),
(4, 4, 104, 1, 12000.00, 12000.00),
(5, 5, 105, 3, 800.00, 2400.00),
(6, 6, 106, 2, 3500.00, 7000.00),
(7, 7, 107, 1, 4500.00, 4500.00),
(8, 8, 108, 5, 250.00, 1250.00),
(9, 9, 109, 2, 1200.00, 2400.00),
(10, 10, 110, 1, 15000.00, 15000.00);
/*==========================================================
    Payments Data
==========================================================*/
INSERT INTO payments
(payment_id, order_id, payment_date, payment_method, payment_amount, payment_status, transaction_id)
VALUES
(1, 1, '2026-02-01', 'Credit Card', 85000.00, 'Completed', 'TXN100001'),
(2, 2, '2026-02-02', 'Debit Card', 65000.00, 'Completed', 'TXN100002'),
(3, 3, '2026-02-03', 'UPI', 11000.00, 'Pending', 'TXN100003'),
(4, 4, '2026-02-04', 'Net Banking', 12000.00, 'Completed', 'TXN100004'),
(5, 5, '2026-02-05', 'Cash', 2400.00, 'Refunded', 'TXN100005'),
(6, 6, '2026-02-06', 'UPI', 7000.00, 'Completed', 'TXN100006'),
(7, 7, '2026-02-07', 'Credit Card', 4500.00, 'Pending', 'TXN100007'),
(8, 8, '2026-02-08', 'Debit Card', 1250.00, 'Completed', 'TXN100008'),
(9, 9, '2026-02-09', 'UPI', 2400.00, 'Completed', 'TXN100009'),
(10, 10, '2026-02-10', 'Net Banking', 15000.00, 'Completed', 'TXN100010');
/*==========================================================
    Shipments Data
==========================================================*/
INSERT INTO shipments
(shipment_id, order_id, shipment_date, delivery_date, shipping_address, courier_name, tracking_number, shipment_status)
VALUES
(1, 1, '2026-02-02', '2026-02-05', 'Hyderabad, Telangana', 'Blue Dart', 'TRK100001', 'Delivered'),
(2, 2, '2026-02-03', '2026-02-06', 'Mumbai, Maharashtra', 'DTDC', 'TRK100002', 'Delivered'),
(3, 3, '2026-02-04', '2026-02-08', 'Delhi', 'Delhivery', 'TRK100003', 'In Transit'),
(4, 4, '2026-02-05', '2026-02-09', 'Bengaluru, Karnataka', 'Blue Dart', 'TRK100004', 'Delivered'),
(5, 5, '2026-02-06', '2026-02-10', 'Chennai, Tamil Nadu', 'India Post', 'TRK100005', 'Cancelled'),
(6, 6, '2026-02-07', '2026-02-11', 'Pune, Maharashtra', 'DTDC', 'TRK100006', 'Delivered'),
(7, 7, '2026-02-08', '2026-02-12', 'Jaipur, Rajasthan', 'Delhivery', 'TRK100007', 'Shipped'),
(8, 8, '2026-02-09', '2026-02-13', 'Kolkata, West Bengal', 'Blue Dart', 'TRK100008', 'Delivered'),
(9, 9, '2026-02-10', '2026-02-14', 'Ahmedabad, Gujarat', 'DTDC', 'TRK100009', 'In Transit'),
(10, 10, '2026-02-11', '2026-02-15', 'Lucknow, Uttar Pradesh', 'India Post', 'TRK100010', 'Shipped');

/*==========================================================
    Returns Data
==========================================================*/
INSERT INTO returns
(return_id, order_id, product_id, return_date, return_reason, refund_amount, return_status)
VALUES
(1, 1, 101, '2026-02-10', 'Damaged Product', 85000.00, 'Approved'),
(2, 2, 102, '2026-02-11', 'Wrong Item', 65000.00, 'Approved'),
(3, 3, 103, '2026-02-12', 'Defective Product', 11000.00, 'Pending'),
(4, 4, 104, '2026-02-13', 'Quality Issue', 12000.00, 'Approved'),
(5, 5, 105, '2026-02-14', 'Changed Mind', 2400.00, 'Rejected'),
(6, 6, 106, '2026-02-15', 'Damaged Product', 7000.00, 'Approved'),
(7, 7, 107, '2026-02-16', 'Wrong Size', 4500.00, 'Pending'),
(8, 8, 108, '2026-02-17', 'Expired Product', 1250.00, 'Approved'),
(9, 9, 109, '2026-02-18', 'Color Mismatch', 2400.00, 'Pending'),
(10, 10, 110, '2026-02-19', 'Not Required', 15000.00, 'Rejected');
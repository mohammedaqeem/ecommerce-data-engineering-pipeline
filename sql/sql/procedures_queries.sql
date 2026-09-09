/*==========================================================
    STORED PROCEDURE Queries TASK 1
==========================================================*/
CREATE PROCEDURE GetAllCustomers
AS
BEGIN
    SELECT
        customer_id,
        customer_name,
        email,
        phone,
        city,
        state,
        country
    FROM coustomer;
END;
/*==========================================================
    STORED PROCEDURE Queries TASK 2
==========================================================*/
CREATE PROCEDURE GetProductsByCategory
            @category_id INT
AS
  BEGIN
       SELECT 
             product_id,
             product_name,
             price,
             brand
FROM products
  WHERE category_id = @category_id;
END;
GO
/*==========================================================
    STORED PROCEDURE Task 3 : GetCustomerOrders
==========================================================*/
/*==========================================================
    STORED PROCEDURE Task 3 : GetCustomerOrders
==========================================================*/

CREATE PROCEDURE GetCustomerOrders
    @customer_id INT
AS
BEGIN
    SELECT
        order_id,
        order_date,
        total_amount,
        payment_status
    FROM orders
    WHERE customer_id = @customer_id;
END;
GO
/*==========================================================
    TRIGGER Task 1 : Prevent Negative Stock
==========================================================*/

CREATE TRIGGER trg_PreventNegativeStock
ON products
AFTER UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT *
        FROM inserted
        WHERE stock_quantity < 0
    )
    BEGIN
        RAISERROR ('Stock quantity cannot be negative.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO
UPDATE products
SET stock_quantity = -5
WHERE product_id = 1;

/*==========================================================
    TRIGGER Task 2 : Prevent Duplicate Email
==========================================================*/

CREATE TRIGGER trg_PreventDuplicateEmail
ON coustomer
AFTER INSERT
AS
BEGIN
    IF EXISTS
    (
        SELECT email
        FROM customers
        GROUP BY email
        HAVING COUNT(email) > 1
    )
    BEGIN
        RAISERROR ('Duplicate email is not allowed.',16,1);
        ROLLBACK TRANSACTION;
    END
END;
GO
/*==========================================================
    TRIGGER Task 3 : Log Deleted Orders
==========================================================*/

CREATE TRIGGER trg_LogDeletedOrders
ON orders
AFTER DELETE
AS
BEGIN
    INSERT INTO deleted_orders
    (
        order_id,
        customer_id,
        order_date,
        order_status,
        total_amount,
        payment_status,
        deleted_date
    )

    SELECT
        order_id,
        customer_id,
        order_date,
        order_status,
        total_amount,
        payment_status,
        GETDATE()
    FROM deleted;
END;
GO
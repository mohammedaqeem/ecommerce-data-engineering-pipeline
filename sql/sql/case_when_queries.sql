/*==========================================================
    CASE WHEN Queries
==========================================================*/
SELECT 
     product_name,
     price,
     CASE
         WHEN  price >= 50000 THEN 'Expensive'
         ELSE 'Affordable'
  END AS price_category
  FROM products;
  /*==========================================================
    CASE WHEN Queries
==========================================================*/
SELECT 
      order_id,
      total_amount,
      CASE 
          WHEN total_amount >= 100000 THEN 'HIGH VALUE'
          WHEN total_amount >= 50000 THEN 'Medium value'
          ELSE 'LOW VALUE'
      END AS order_category
FROM orders;
/*==========================================================
    CASE WHEN Queries
==========================================================*/
SELECT 
      payment_id,
      payment_amount,
      payment_status,
      CASE
          WHEN payment_status = 'paid' THEN 'successful'
          WHEN payment_status = 'pending' THEN 'IN Progress'
          ELSE 'Failed'
      END AS payment_category
FROM payments;
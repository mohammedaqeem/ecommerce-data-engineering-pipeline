import os

# --------------------------------------------------
# 0. SET JAVA 17 FOR PYSPARK
# --------------------------------------------------

os.environ["JAVA_HOME"] = r"C:\Program Files\Java\jdk-17"
os.environ["PATH"] = (
    os.environ["JAVA_HOME"] + r"\bin;" + os.environ["PATH"]
)

import pyodbc

from pyspark.sql import SparkSession
from pyspark.sql.functions import (
    col,
    when,
    trim,
    sum,
    monotonically_increasing_id
)


# --------------------------------------------------
# 1. START PYSPARK
# --------------------------------------------------

spark = SparkSession.builder \
    .master("local[2]") \
    .appName("EcommerceDataEngineering") \
    .getOrCreate()

print("PySpark started successfully!")


# --------------------------------------------------
# 2. SQL SERVER CONNECTION
# --------------------------------------------------

connection_string = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=localhost,1433;"
    "DATABASE=ecomerce_data_warehouse;"
    "Trusted_Connection=yes;"
    "Encrypt=yes;"
    "TrustServerCertificate=yes;"
)

conn = pyodbc.connect(connection_string)

print("SQL Server connection successful!")


# --------------------------------------------------
# 3. EXTRACT PRODUCTS
# --------------------------------------------------

cursor = conn.cursor()

cursor.execute(
    "SELECT * FROM staging_products"
)

columns = [
    column[0]
    for column in cursor.description
]

rows = cursor.fetchall()

cursor.close()
conn.close()

print("Data extracted successfully!")
print("Rows extracted:", len(rows))


# --------------------------------------------------
# 4. CREATE PRODUCT DATAFRAME
# --------------------------------------------------

df = spark.createDataFrame(
    [tuple(row) for row in rows],
    columns
)

print(
    "PySpark Product DataFrame created successfully!"
)


# --------------------------------------------------
# 5. LOAD CATEGORY DIMENSION
# --------------------------------------------------

conn = pyodbc.connect(connection_string)

cursor = conn.cursor()

cursor.execute(
    "SELECT * FROM dim_categories"
)

category_columns = [
    column[0]
    for column in cursor.description
]

category_rows = cursor.fetchall()

cursor.close()


# --------------------------------------------------
# 6. LOAD SUPPLIER DIMENSION
# --------------------------------------------------

cursor = conn.cursor()

cursor.execute(
    "SELECT * FROM dim_suppliers"
)

supplier_columns = [
    column[0]
    for column in cursor.description
]

supplier_rows = cursor.fetchall()

cursor.close()


# --------------------------------------------------
# 7. LOAD CUSTOMER DIMENSION
# --------------------------------------------------

cursor = conn.cursor()

cursor.execute(
    "SELECT * FROM dim_customers"
)

customer_columns = [
    column[0]
    for column in cursor.description
]

customer_rows = cursor.fetchall()

cursor.close()


# --------------------------------------------------
# 8. LOAD ORDERS
# --------------------------------------------------

cursor = conn.cursor()

cursor.execute(
    "SELECT * FROM orders"
)

orders_columns = [
    column[0]
    for column in cursor.description
]

orders_rows = cursor.fetchall()

cursor.close()


# --------------------------------------------------
# 9. LOAD ORDER ITEMS
# --------------------------------------------------

cursor = conn.cursor()

cursor.execute(
    "SELECT * FROM order_items"
)

order_items_columns = [
    column[0]
    for column in cursor.description
]

order_items_rows = cursor.fetchall()

cursor.close()
conn.close()


# --------------------------------------------------
# 10. CREATE CATEGORY DATAFRAME
# --------------------------------------------------

df_categories = spark.createDataFrame(
    [tuple(row) for row in category_rows],
    category_columns
)

print(
    "Category DataFrame created successfully!"
)


# --------------------------------------------------
# 11. CREATE SUPPLIER DATAFRAME
# --------------------------------------------------

df_suppliers = spark.createDataFrame(
    [tuple(row) for row in supplier_rows],
    supplier_columns
)

print(
    "Supplier DataFrame created successfully!"
)


# --------------------------------------------------
# 12. CREATE CUSTOMER DATAFRAME
# --------------------------------------------------

df_customers = spark.createDataFrame(
    [tuple(row) for row in customer_rows],
    customer_columns
)

print(
    "Customer DataFrame created successfully!"
)


# --------------------------------------------------
# 13. CREATE ORDERS DATAFRAME
# --------------------------------------------------

df_orders = spark.createDataFrame(
    [tuple(row) for row in orders_rows],
    orders_columns
)

print(
    "Orders DataFrame created successfully!"
)


# --------------------------------------------------
# 14. CREATE ORDER ITEMS DATAFRAME
# --------------------------------------------------

df_order_items = spark.createDataFrame(
    [tuple(row) for row in order_items_rows],
    order_items_columns
)

print(
    "Order Items DataFrame created successfully!"
)


# --------------------------------------------------
# 15. DISPLAY SCHEMAS
# --------------------------------------------------

print("Customer Schema:")
df_customers.printSchema()

print("Orders Schema:")
df_orders.printSchema()

print("Order Items Schema:")
df_order_items.printSchema()


# --------------------------------------------------
# 16. TRANSFORM 1: CALCULATE STOCK VALUE
# --------------------------------------------------

df = df.withColumn(
    "stock_value",
    col("price") * col("stock_quantity")
)

print(
    "stock_value calculated successfully!"
)


# --------------------------------------------------
# 17. TRANSFORM 2: CREATE STOCK STATUS
# --------------------------------------------------

df = df.withColumn(
    "stock_status",
    when(
        col("stock_quantity") == 0,
        "Out of Stock"
    )
    .when(
        col("stock_quantity") <= 50,
        "Low Stock"
    )
    .otherwise("In Stock")
)

print(
    "stock_status calculated successfully!"
)


# --------------------------------------------------
# 18. JOIN CATEGORY
# --------------------------------------------------

df = df.join(
    df_categories.select(
        "category_id",
        "category_name"
    ),
    on="category_id",
    how="left"
)

print(
    "Category join completed successfully!"
)


# --------------------------------------------------
# 19. JOIN SUPPLIER
# --------------------------------------------------

df = df.join(
    df_suppliers.select(
        "supplier_id",
        "supplier_name"
    ),
    on="supplier_id",
    how="left"
)

print(
    "Supplier join completed successfully!"
)


# --------------------------------------------------
# 20. CHECK NULL VALUES
# --------------------------------------------------

null_counts = df.select(
    *[
        sum(
            col(c).isNull().cast("int")
        ).alias(c)
        for c in df.columns
    ]
)

print("NULL value check:")

null_counts.show()


# --------------------------------------------------
# 21. CLEAN TEXT COLUMNS
# --------------------------------------------------

df = df.withColumn(
    "product_name",
    trim(col("product_name"))
)

df = df.withColumn(
    "brand",
    trim(col("brand"))
)

df = df.withColumn(
    "category_name",
    trim(col("category_name"))
)

df = df.withColumn(
    "supplier_name",
    trim(col("supplier_name"))
)

print(
    "Text columns cleaned successfully!"
)


# --------------------------------------------------
# 22. CHECK DUPLICATE PRODUCT IDs
# --------------------------------------------------

duplicate_count = (
    df.groupBy("product_id")
      .count()
      .filter(col("count") > 1)
      .count()
)

print(
    "Duplicate product IDs:",
    duplicate_count
)


# --------------------------------------------------
# 23. VALIDATE PRODUCT PRICES
# --------------------------------------------------

invalid_price_count = df.filter(
    col("price") <= 0
).count()

print(
    "Invalid product prices:",
    invalid_price_count
)


# --------------------------------------------------
# 24. VALIDATE STOCK QUANTITY
# --------------------------------------------------

invalid_stock_count = df.filter(
    col("stock_quantity") < 0
).count()

print(
    "Invalid stock quantities:",
    invalid_stock_count
)


# --------------------------------------------------
# 25. AGGREGATION: STOCK BY CATEGORY
# --------------------------------------------------

category_stock_summary = (
    df.groupBy("category_name")
      .sum("stock_quantity")
      .withColumnRenamed(
          "sum(stock_quantity)",
          "total_stock_quantity"
      )
)

print(
    "Category stock aggregation completed successfully!"
)

category_stock_summary.show(
    truncate=False
)


# --------------------------------------------------
# 26. AGGREGATION: STOCK VALUE BY CATEGORY
# --------------------------------------------------

category_value_summary = (
    df.groupBy("category_name")
      .sum("stock_value")
      .withColumnRenamed(
          "sum(stock_value)",
          "total_stock_value"
      )
)

print(
    "Category stock value aggregation completed successfully!"
)

category_value_summary.show(
    truncate=False
)


# --------------------------------------------------
# 27. AGGREGATION: STOCK BY SUPPLIER
# --------------------------------------------------

supplier_summary = (
    df.groupBy("supplier_name")
      .agg(
          sum("stock_quantity").alias(
              "total_stock_quantity"
          ),
          sum("stock_value").alias(
              "total_stock_value"
          )
      )
)

print(
    "Supplier stock aggregation completed successfully!"
)

supplier_summary.show(
    truncate=False
)


# --------------------------------------------------
# 28. PREPARE PRODUCT FACT DATASET
# --------------------------------------------------

fact_products = df.select(
    "product_id",
    "category_id",
    "supplier_id",
    "price",
    "stock_quantity",
    "stock_value",
    "stock_status",
    "created_date"
)

print(
    "Product fact dataset prepared successfully!"
)

fact_products.show(
    truncate=False
)


# --------------------------------------------------
# 29. JOIN ORDERS AND ORDER ITEMS
# --------------------------------------------------

sales_base = df_orders.join(
    df_order_items,
    on="order_id",
    how="inner"
)

print(
    "Orders and Order Items joined successfully!"
)

sales_base.show(
    truncate=False
)


# --------------------------------------------------
# 30. JOIN CUSTOMER DIMENSION
# --------------------------------------------------

sales_base = sales_base.join(
    df_customers.select(
        "customer_id",
        "customer_key"
    ),
    on="customer_id",
    how="left"
)

print(
    "Customer dimension join completed successfully!"
)


# --------------------------------------------------
# 31. JOIN PRODUCT DIMENSION
# --------------------------------------------------

sales_base = sales_base.join(
    df.select(
        "product_id",
        "category_id",
        "supplier_id"
    ),
    on="product_id",
    how="left"
)

print(
    "Product dimension join completed successfully!"
)


# --------------------------------------------------
# 32. JOIN CATEGORY DIMENSION
# --------------------------------------------------

sales_base = sales_base.join(
    df_categories.select(
        "category_id",
        "category_key"
    ),
    on="category_id",
    how="left"
)

print(
    "Category dimension join completed successfully!"
)


# --------------------------------------------------
# 33. JOIN SUPPLIER DIMENSION
# --------------------------------------------------

sales_base = sales_base.join(
    df_suppliers.select(
        "supplier_id",
        "supplier_key"
    ),
    on="supplier_id",
    how="left"
)

print(
    "Supplier dimension join completed successfully!"
)


# --------------------------------------------------
# 34. PREPARE FACT SALES DATASET
# --------------------------------------------------

fact_sales = sales_base.select(
    "order_id",
    "customer_key",
    "product_id",
    "category_key",
    "supplier_key",
    "order_date",
    "quantity",
    "total_price"
)


# --------------------------------------------------
# 35. RENAME COLUMNS FOR FACT SALES
# --------------------------------------------------

fact_sales = fact_sales.withColumnRenamed(
    "product_id",
    "product_key"
)

fact_sales = fact_sales.withColumnRenamed(
    "total_price",
    "sales_amount"
)


# --------------------------------------------------
# 36. CREATE SALES KEY
# --------------------------------------------------

fact_sales = fact_sales.withColumn(
    "sales_key",
    monotonically_increasing_id()
)


# --------------------------------------------------
# 37. SELECT FINAL FACT SALES COLUMNS
# --------------------------------------------------

fact_sales = fact_sales.select(
    "sales_key",
    "order_id",
    "customer_key",
    "product_key",
    "category_key",
    "supplier_key",
    "order_date",
    "quantity",
    "sales_amount"
)


# --------------------------------------------------
# 38. DISPLAY FACT SALES
# --------------------------------------------------

print(
    "Fact sales dataset prepared successfully!"
)

fact_sales.show(
    truncate=False
)


# --------------------------------------------------
# 39. FACT SALES SCHEMA
# --------------------------------------------------

print("Fact Sales Schema:")

fact_sales.printSchema()


# --------------------------------------------------
# 40. LOAD FACT SALES INTO SQL SERVER
# --------------------------------------------------

conn = pyodbc.connect(connection_string)

cursor = conn.cursor()

insert_query = """
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
VALUES (?, ?, ?, ?, ?, ?, ?, ?)
"""

for row in fact_sales.collect():

    cursor.execute(
        insert_query,
        int(row["order_id"]),
        int(row["customer_key"]),
        int(row["product_key"]),
        int(row["category_key"]),
        int(row["supplier_key"]),
        row["order_date"],
        int(row["quantity"]),
        row["sales_amount"]
    )

conn.commit()

print(
    "Fact sales loaded successfully!"
)

cursor.close()
conn.close()


# --------------------------------------------------
# 41. ETL COMPLETED
# --------------------------------------------------

print(
    "ETL transformation completed successfully!"
)


# --------------------------------------------------
# 42. STOP PYSPARK
# --------------------------------------------------

spark.stop()
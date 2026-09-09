
import logging

import pandas as pd
from sqlalchemy import create_engine


# --------------------------------------------------
# Configuration
# --------------------------------------------------

SERVER = r"localhost\SQLEXPRESS"
DATABASE = "ecomerce_data_warehouse"

CONNECTION_STRING = (
    "mssql+pyodbc://@"
    + SERVER
    + "/"
    + DATABASE
    + "?driver=ODBC+Driver+17+for+SQL+Server"
    + "&trusted_connection=yes"
)

SOURCE_TABLE = "products"
TARGET_TABLE = "staging_products"


# --------------------------------------------------
# Logging
# --------------------------------------------------

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
)

logger = logging.getLogger(__name__)


# --------------------------------------------------
# 1. Create database connection
# --------------------------------------------------

def get_engine():
    """Create a connection to SQL Server."""
    return create_engine(CONNECTION_STRING)


# --------------------------------------------------
# 2. Extract data
# --------------------------------------------------

def extract_products(engine):
    """Read products from the source table."""
    query = f"SELECT * FROM {SOURCE_TABLE}"

    df = pd.read_sql(query, engine)

    logger.info("Extracted %s products.", len(df))

    return df


# --------------------------------------------------
# 3. Transform data
# --------------------------------------------------

def transform_products(df):
    """Clean product data."""
    df = df.copy()

    # Remove unnecessary spaces from text columns.
    for column in ["product_name", "brand"]:
        if column in df.columns:
            df[column] = df[column].astype("string").str.strip()

    logger.info("Product transformation completed.")

    return df


# --------------------------------------------------
# 4. Validate data
# --------------------------------------------------

def validate_products(df):
    """Check the important product data quality rules."""

    checks = {}

    if "product_id" in df.columns:
        checks["duplicate_product_ids"] = df["product_id"].duplicated().sum()

    if "price" in df.columns:
        checks["invalid_prices"] = (df["price"] < 0).sum()

    if "stock_quantity" in df.columns:
        checks["invalid_stock"] = (df["stock_quantity"] < 0).sum()

    if "product_id" in df.columns:
        checks["null_product_ids"] = df["product_id"].isna().sum()

    if "category_id" in df.columns:
        checks["null_category_ids"] = df["category_id"].isna().sum()

    if "supplier_id" in df.columns:
        checks["null_supplier_ids"] = df["supplier_id"].isna().sum()

    if "created_date" in df.columns:
        checks["null_created_dates"] = df["created_date"].isna().sum()

    logger.info("Validation results: %s", checks)

    invalid_checks = {
        name: count
        for name, count in checks.items()
        if count > 0
    }

    if invalid_checks:
        raise ValueError(
            f"Data validation failed: {invalid_checks}"
        )

    logger.info("All validation checks passed.")


# --------------------------------------------------
# 5. Load data
# --------------------------------------------------

def load_to_staging(df, engine):
    """Replace the staging table with fresh data."""
    df.to_sql(
        TARGET_TABLE,
        engine,
        if_exists="replace",
        index=False,
    )

    logger.info(
        "Loaded %s products into %s.",
        len(df),
        TARGET_TABLE,
    )


# --------------------------------------------------
# 6. Main ETL pipeline
# --------------------------------------------------

def run_etl():
    """Run the complete product ETL pipeline."""

    logger.info("Starting E-commerce ETL pipeline.")

    engine = get_engine()

    try:
        df = extract_products(engine)
        df = transform_products(df)
        validate_products(df)
        load_to_staging(df, engine)

        logger.info("E-commerce ETL pipeline completed successfully.")

    finally:
        engine.dispose()


# --------------------------------------------------
# Run only when this file is executed directly.
# Airflow can import run_etl() without running it.
# --------------------------------------------------

if __name__ == "__main__":
    run_etl()
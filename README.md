# E-commerce Data Engineering Pipeline

## Project Overview

This project demonstrates an end-to-end data engineering pipeline for an e-commerce business.

The project starts with transactional data stored in SQL Server and processes the data through data warehousing, data validation, Python/Pandas ETL, PySpark ETL, and Apache Airflow orchestration.

## Project Architecture

SQL Server (OLTP)
        ↓
Data Warehouse
        ↓
Data Validation
        ↓
Python / Pandas ETL
        ↓
PySpark ETL
        ↓
Apache Airflow
        ↓
Automated Data Pipeline

## Technologies Used

- SQL Server
- SQL
- Python
- Pandas
- PySpark
- Apache Airflow
- GitHub

## Project Structure

```text
ecommerce-data-engineering-pipeline/
│
├── Airflow/
│   └── first_dag.py
│
├── Data warehouse/
│   ├── create_data_warehouse.sql
│   ├── load_data_warehouse.sql
│   └── validate_data_warehouse.sql
│
├── pyspark_etl/
│   └── etl_pyspark.py
│
├── python_etl/
│   └── etl_pipeline.py
│
└── sql/
    └── SQL practice and project queries

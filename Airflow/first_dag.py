from datetime import datetime

from airflow.sdk import DAG
from airflow.providers.standard.operators.bash import BashOperator


with DAG(
    dag_id="ecommerce_etl_pipeline",
    start_date=datetime(2026, 9, 5),
    schedule=None,
    catchup=False,
) as dag:

    run_ecommerce_etl = BashOperator(
        task_id="run_ecommerce_etl",
        bash_command=(
            "cmd.exe /c C:/PROGRA~1/Python313/python.exe "
            "D:/ECOMMERCE_DATA_WAREHOUSE/python_etl/etl_pipeline.py"
        ),
    )
from airflow.sdk import dag, task
from ingest_data import trigger_databricks_job

@dag
def orchestrate():
    
    @task
    def ingest_data():
        trigger_databricks_job()

    @task.bash
    def rm_trg():
        return 'rm -rf /opt/airflow/main_project/target && rm -rf /opt/airflow/main_project/logs'
    
    @task.bash
    def source_freshness():
        return 'cd /opt/airflow/main_project && dbt source freshness'

    @task.bash
    def run_silver():
        return 'cd /opt/airflow/main_project && dbt run --select silver'

    @task.bash
    def dbt_test():
        return 'cd /opt/airflow/main_project && dbt test'

    @task.bash
    def run_gold():
        return 'cd /opt/airflow/main_project && dbt run --select gold'
    
    @task.bash
    def run_snapshot():
        return 'cd /opt/airflow/main_project && dbt snapshot'
    
    ingest_data() >> rm_trg() >> source_freshness() >> run_silver() >> dbt_test() >> run_gold() >> run_snapshot()
orchestrate_dag = orchestrate()

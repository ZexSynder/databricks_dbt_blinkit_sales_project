import os
from databricks.sdk import WorkspaceClient
from dotenv import load_dotenv

def trigger_databricks_job():
    load_dotenv()  # Load environment variables from .env file

    # Authenticates using environment variables or ~/.databrickscfg
    w = WorkspaceClient(
        host=os.environ.get("HOST_DATABRICKS"), 
        token=os.environ.get("TOKEN_DATABRICKS")
    )

    JOB_ID = os.environ.get("JOB_ID")

    print(f"Triggering Job ID: {JOB_ID}...")

    run_wait_handle = w.jobs.run_now(job_id=JOB_ID)
    print(f"Run triggered successfully. Run ID: {run_wait_handle.run_id}")
    print("Waiting for the job to complete (this will block until finished)...")

    run_info = run_wait_handle.result()

    result_state = run_info.state.result_state
    life_cycle_state = run_info.state.life_cycle_state

    print(f"\nJob finished!")
    print(f"Lifecycle State: {life_cycle_state.value}")  # Expected: TERMINATED
    print(f"Result State: {result_state.value}")        # Expected: SUCCESS, FAILED, or CANCELED

    # Optional: Raise an exception if the job failed
    if result_state.value != "SUCCESS":
        raise RuntimeError(f"Job failed or was canceled. Final state: {result_state.value}")

if __name__ == "__main__":
    trigger_databricks_job()
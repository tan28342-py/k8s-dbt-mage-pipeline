import os
import re
import pandas as pd
from google.cloud import bigquery
from google.oauth2 import service_account
from mage_ai.settings.repo import get_repo_path

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter


@data_exporter
def export_data(data, *args, **kwargs):
    df = data

    project_id = "data-pipeline-poc-513121"
    dataset_id = "raw"
    table_id = "raw_kaggle_talent_recruitment"
    raw_table_ref = f"{project_id}.{dataset_id}.{table_id}"

    # Minimal header cleanup: BigQuery requires column names without spaces/symbols
    df.columns = [re.sub(r'[^a-zA-Z0-9_]', '_', c.strip().lower()) for c in df.columns]

    # Convert all columns to string so raw data loads without failing schema checks
    df = df.astype(str)

    project_dir = get_repo_path()
    key_path = os.path.join(project_dir, 'data-pipeline-poc-513121-4aecb4bf52d6.json')
    credentials = service_account.Credentials.from_service_account_file(key_path)
    client = bigquery.Client(credentials=credentials, project=project_id)

    # 1. Ensure the dataset exists (creates it if missing, does nothing if it already exists)
    dataset_ref = bigquery.Dataset(f"{project_id}.{dataset_id}")
    dataset_ref.location = "US"  # Change this if your data needs to live in another region (e.g., 'EU')
    client.create_dataset(dataset_ref, exists_ok=True)

    # 2. Configure load job
    job_config = bigquery.LoadJobConfig(
        write_disposition=bigquery.WriteDisposition.WRITE_TRUNCATE,
        autodetect=True
    )

    # 3. Load the data
    load_job = client.load_table_from_dataframe(df, raw_table_ref, job_config=job_config)
    load_job.result()
    print(f"Raw data successfully loaded into {raw_table_ref}")


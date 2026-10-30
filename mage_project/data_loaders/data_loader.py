import io
import zipfile
import requests
import pandas as pd

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data(*args, **kwargs):
    token = 'KAGGLE_API_TOKEN'
    if not token:
        raise ValueError("KAGGLE_API_TOKEN not found in Mage Secrets!")

    # Dataset Slug: owner/dataset-name
    owner_slug = 'colabsss'
    dataset_slug = 'talent-recruitment-dataset'
    url = f"https://www.kaggle.com/api/v1/datasets/download/{owner_slug}/{dataset_slug}"

    headers = {"Authorization": f"Bearer {token}"}

    print(f"Downloading from {url}...")
    response = requests.get(url, headers=headers, stream=True)
    response.raise_for_status()

    # Read zip archive in-memory
    with zipfile.ZipFile(io.BytesIO(response.content)) as z:
        file_list = z.namelist()
        print(f"Files found in archive: {file_list}")

        # Find CSV or Excel files inside the zip
        target_file = None
        for f in file_list:
            if f.endswith(('.csv', '.xlsx', '.xls')):
                target_file = f
                break

        if not target_file:
            raise FileNotFoundError("No CSV or Excel (.xlsx/.xls) file found in the archive.")

        print(f"Reading file: {target_file}")
        with z.open(target_file) as f:
            if target_file.endswith('.csv'):
                df = pd.read_csv(f)
            else:
                df = pd.read_excel(f, engine='openpyxl')

    print(f"Successfully loaded {len(df)} rows and {len(df.columns)} columns.")
    return df
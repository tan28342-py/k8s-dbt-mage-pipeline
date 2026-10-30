# Orchestrating ELT with Mage.ai, Kubernetes & BigQuery
 
<p align="center">
  <img src="https://github.com/tan28342-py/k8s-dbt-mage-pipeline/blob/a7f6fd7858c15bcdc68a4c764f3aa22736a51811/system-architecture-mage-k8s.png" alt="Pipeline Architecture" width="85%"/>
</p>

[![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)](#)
[![Mage.ai](https://img.shields.io/badge/Mage.ai-5B21B6?style=for-the-badge&logo=sparkles&logoColor=white)](https://github.com/mage-ai/mage-ai)
[![Google BigQuery](https://img.shields.io/badge/Google_BigQuery-669DF6?style=for-the-badge&logo=googlecloud&logoColor=white)](#)
[![dbt](https://img.shields.io/badge/dbt-FF694B?style=for-the-badge&logo=dbt&logoColor=white)](#)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](#)
[![Python](https://img.shields.io/badge/Python_3.10+-3776AB?style=for-the-badge&logo=python&logoColor=white)](#)

An end-to-end modern ELT data engineering platform simulating a talent acquisition and recruitment intelligence system. The pipeline automatically ingests raw data via the Kaggle API, coordinates workloads on a containerized, self-healing **Kubernetes** cluster running **Mage.ai**, and executes transformations inside **Google BigQuery** using modular **dbt** models to produce analytics-ready dimensional tables.

---

> [!NOTE]
> **Proof of Concept (PoC) & Hardware Disclaimer:**  
> This project is designed as an architectural proof-of-concept. Due to local workstation hardware constraints, the **Horizontal Pod Autoscaler (HPA)** was configured with tuned/lower CPU and memory request boundaries to simulate auto-scaling and resilience under synthetic workloads.

---

## Data Source & References
* **Dataset:** [Talent Recruitment & Job Matching Dataset](https://www.kaggle.com/datasets/colabsss/talent-recruitment-dataset)
* **Orchestration Tool:** [Mage-ai Repository](https://github.com/mage-ai/mage-ai)

---

### Self-Hosting Mage.ai Locally with Kubernetes
* Set up Kubernetes file structure
* Build custom Mage Docker image with `mage-requirements.txt`
* Install `metrics-server` to monitor pod resource usage
* Set up Horizontal Pod Autoscaling (HPA) to increase infrastructure durability
* Configure Persistent Volume Claim (PVC) for storage

### Credentials and Connection Setup
* Configure Kaggle API token
* Set up GCP Service Account for BigQuery data ingestion and retrival 
* Configure dbt connection profile

### ELT Pipeline Setup with Mage
* Call Kaggle API to extract dataset
* Load raw data into BigQuery raw table
* Transform and normalize raw data into base tables using dbt

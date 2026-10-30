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

## 🏗️ Architecture Overview

```mermaid
flowchart LR
    subgraph Ingestion ["1. Data Ingestion"]
        K[Kaggle API] -->|Raw CSVs| M[Mage.ai Pipeline]
    end

    subgraph K8s ["2. Orchestration Layer (Local Kubernetes)"]
        direction TB
        M --> D[Custom Mage Docker Image]
        D --> PVC[(Persistent Volume Claim)]
        MS[Metrics Server] -.->|Monitor Load| HPA[Horizontal Pod Autoscaler]
        HPA -.->|Scale Pods| D
    end

    subgraph Warehouse ["3. Storage & Transformation (Google Cloud)"]
        M -->|Load Raw Data| BQR[(BigQuery: Raw Dataset)]
        BQR -->|In-Warehouse Transformation| DBT[dbt Models]
        DBT --> BQB[(BigQuery: Analytics / Base Tables)]
    end

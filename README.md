<p align="center">
  <img src="images/banner.jpg" width="100%" alt="Ecobici Data Pipeline" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/status-active-brightgreen" />
  <img src="https://img.shields.io/badge/cloud-GCP-blue" />
  <img src="https://img.shields.io/badge/IaC-Terraform-623ce4" />
</p>

# 🚴 Ecobici Data Pipeline

This project showcases the development of a complete batch data pipeline using open data from Ecobici CDMX. The main goal is to demonstrate end-to-end capabilities in orchestration, ingestion, modeling, and data visualization in the cloud, rather than performing deep analytical insights on the dataset itself.

---

## 🌐 Architecture Overview

![Pipeline Diagram](images/pipeline_diagram.png)

---

## ☁️ Cloud Infrastructure

The pipeline leverages **Google Cloud Platform (GCP)** services:

- 📁 GCS (Google Cloud Storage): acts as the Data Lake
- 🧮 BigQuery: for data ingestion and transformation
- 📊 Looker Studio: for final data visualization
- ⚙️ **Terraform**: used to provision all cloud infrastructure components

> ⚠️ **Note:** In a real-world production setting, Kestra would typically run in the cloud (via Kubernetes or a VM).  
> In this project, **Kestra is executed locally** to orchestrate the pipeline while minimizing cloud costs.  
> All data infrastructure lives in the cloud and is fully managed via Terraform for scalability and reproducibility.

---

## 🧩 Pipeline Components

| Stage                 | Tool              | Description                                                                   |
|----------------------|-------------------|-------------------------------------------------------------------------------|
| Orchestration         | Kestra            | Locally running orchestrator triggering each batch pipeline step             |
| Data Lake             | Google Cloud Storage | Stores raw monthly files from Ecobici                                        |
| Ingestion to DWH      | BigQuery          | Loads GCS files into intermediate staging tables                             |
| Transformations       | dbt               | Transforms staging tables into joined models, containerized and orchestrated |
| Visualization         | Looker Studio     | Dashboard with at least 2 visual insights                                     |

---

## 🛠️ How to Run

```bash
# 1. Initialize and apply Terraform
cd terraform/
terraform init
terraform apply

# 2. Run the pipeline with Kestra CLI
cd kestra/
kestra start

# 3. Explore the data in BigQuery
# 4. Open the dashboard in Looker Studio
```

## 📊 Dashboard

🔗 View in Looker Studio

## Project Structure


ecobici-data-pipeline/
├── terraform/           # Infrastructure as Code for GCP resources
├── kestra/              # Kestra workflow definitions
├── dbt/                 # dbt models and project files
├── dashboard/           # Dashboard screenshots or link
├── img/                 # Diagrams, banners, visuals
├── README.md
└── ...

## 🐳 Optional: Run in Docker

To facilitate reproducibility, you can optionally run the pipeline inside a pre-configured container:

``` bash
Copiar
Editar
cd docker/
docker build -t ecobici-pipeline .
docker run --rm -v $(pwd):/app ecobici-pipeline
```
This image includes Terraform, dbt and Kestra CLI, allowing full pipeline execution from a single container.

## 📚 References
DataTalksClub – Data Engineering Zoomcamp

Ecobici Open Data

## 👤 Author
Your Name
GitHub • LinkedIn
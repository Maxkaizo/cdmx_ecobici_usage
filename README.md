# 🚴 Mexico City's Ecobici Data Pipeline

This project showcases the development of a complete batch data pipeline using open data from Ecobici CDMX. The main goal is to demonstrate end-to-end capabilities in orchestration, ingestion, modeling, and data visualization in the cloud, rather than performing deep analytical insights on the dataset itself.
<p align="center">
  <img src="images/banner_gpt.png" width="100%" alt="Ecobici Data Pipeline" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/status-active-brightgreen" />
  <img src="https://img.shields.io/badge/cloud-GCP-blue" />
  <img src="https://img.shields.io/badge/IaC-Terraform-623ce4" />
  <img src="https://img.shields.io/badge/orchestration-Kestra-7B3FE4" />
  <img src="https://img.shields.io/badge/etl-dltHub-00B86B" />
  <img src="https://img.shields.io/badge/transform-dbt-F04E98" />
  <img src="https://img.shields.io/badge/data%20lake-GCS-34A853" />
  <img src="https://img.shields.io/badge/warehouse-BigQuery-669DF6" />
  <img src="https://img.shields.io/badge/visualization-Looker%20Studio-4285F4" />
  <img src="https://img.shields.io/badge/language-Python-3776AB" />
  <img src="https://img.shields.io/badge/containers-Docker-2496ED" />
  <img src="https://img.shields.io/badge/source-Ecobici%20CDMX-0E9E58" />
</p>


---
# 🧭 About Ecobici
Ecobici is Mexico City's public bike-sharing system, designed to provide a sustainable and accessible mobility alternative for urban residents. Since its launch in 2010, Ecobici has become one of the largest bike-sharing systems in Latin America, with hundreds of stations, thousands of bicycles, and millions of trips logged.

To promote transparency and enable data-driven urban planning, Ecobici publishes monthly open datasets, which include detailed records of each trip: timestamps, origin and destination stations, user type, and duration.

> This dataset is particularly suited for data engineering projects due to:
> - Its **recurring and structured format**, ideal for batch pipelines.
> - Real-world complexity (e.g., missing data, varying formats).
> - Public accessibility without the need for synthetic data.
> - Its size, which is large enough to be meaningful, but manageable for cloud tools like BigQuery.

---

## 🌐 Architecture Overview

![Pipeline Diagram](images/diagram.png)

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

| Stage                 | Tool                    | Description                                                                 |
|----------------------|-------------------------|-----------------------------------------------------------------------------|
| Orchestration         | Kestra                  | Orchestrator triggering each step in the batch pipeline    |
| Data Extraction       | Python + Docker         | Scrapes and downloads historical CSV/JSON files from Ecobici website       |
| Data Lake             | Google Cloud Storage    | Stores raw monthly files from Ecobici in GCS buckets                       |
| Ingestion to DWH      | dlt + BigQuery          | Extracts data from GCS and loads it into BigQuery staging tables           |
| Transformations       | dbt + Docker            | Transforms staging tables into cleaned and joined models                   |
| Visualization         | Looker Studio           | Dashboard with at least 2 visual insights on bike usage                    |

---

## 📁 Project Structure

``` bash
ecobici-data-pipeline/
├── dbt/                              # dbt project (models, profiles, etc.)
├── images/                           # Diagrams and visual assets
├── kestra/                           # Kestra orchestration config and flows
├── src/                              # Source scripts for data extraction
├── terraform/                        # Terraform configuration files
├── LICENSE                           # License file
└── README.md                         # Project documentation
```

---


## 📊 Dashboard

🔗 View in Looker Studio

- https://lookerstudio.google.com/s/gFyZHSl4BD8

## Walkthrough

Here you can find a complete [Walkthrough](https://github.com/Maxkaizo/cdmx_ecobici_usage/blob/main/walkthrough/walkthrough.md) of how the pipeline works

---

## 🔁 Reproducibility

### ✅ Prerequisites
To reproduce this project, make sure you have the following in place:

A Google Cloud Platform (GCP) project with the following APIs enabled:

- Cloud Storage API
- BigQuery API
- IAM API

A service account with the following roles:

- roles/editor
- roles/storage.admin
- roles/bigquery.admin

A key file (.json) must be generated for this service account, as it will be used by Terraform, dbt, and other tools to authenticate.

Tools installed on your local machine:

- Terraform
- Docker

Once these are set, you'll be ready to provision infrastructure and run the data pipeline as described in the following sections.

You can set the variables file according your naming conventions and use case, for example:

``` bash
variable "project" {
  description = "Project"
  default     = "dataeng-448500"
}

variable "region" {
  description = "Region"
  default     = "us-central1"
}
```

### Quickstart

To run this project locally:

1. Clone the repository:

``` bash
git clone https://github.com/Maxkaizo/cdmx_ecobici_usage.git
cd cdmx_ecobici_usage
```

2. Prepare environment variables:

Move into the Kestra folder and create a .env file containing your GCP configuration Base64-encoded:

``` bash
cd kestra/
```

.env example:

``` env
# Kestra environment variables
SECRET_GCP_PROJECT_ID=encoded_example=
SECRET_GCP_LOCATION=encoded_example=
SECRET_GCP_BUCKET_NAME=encoded_example=
SECRET_GCP_CREDS=encoded_example=
```
You can encode values using echo -n 'your-value' | base64.

The `SECRET_GCP_CREDS` must contain the full content of your service account key (not just the path).

3. Start the environment with Docker Compose:

``` bash
docker-compose up
```
This will launch Kestra locally along with required services.

4. Access the UI and run the flow:

Open http://localhost:8080 in your browser.

5. Run the pipeline:

From the Kestra UI, trigger the ecobici_01 flow. It will:

- Scrape and download Ecobici trip data
- Upload files to GCS
- Load data into BigQuery
- Run dbt transformations

6. (Optional) Create a dashboard in looker studio

- Connect the dashboard to the dataset and select data

---

## 📚 References

DataTalksClub – Data Engineering Zoomcamp

https://github.com/DataTalksClub/data-engineering-zoomcamp

Ecobici Open Data

https://ecobici.cdmx.gob.mx/datos-abiertos/

---

## 👤 Author
José Luis Martínez Olvera • [GitHub](https://github.com/Maxkaizo) • [LinkedIn](www.linkedin.com/in/jlmartinezol)
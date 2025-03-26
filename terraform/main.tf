terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.17.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}

resource "google_storage_bucket" "dataeng-448500-ecobici-bucket" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

# Crear un dataset de BigQuery
resource "google_bigquery_dataset" "dataeng_448500_ecobici_ds" {
  dataset_id    = var.bq_dataset_name # Dataset name
  location      = var.location        # Dataset location
  friendly_name = "Ecobici"
  description   = "Ecobici rides information"
}
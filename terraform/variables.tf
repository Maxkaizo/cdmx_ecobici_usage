variable "credentials" {
  description = "My Credentials"
  default     = ".keys/my-creds.json"
}

variable "project" {
  description = "Project"
  default     = "dataeng-448500"
}

variable "region" {
  description = "Region"
  default     = "us-central1"
}

variable "location" {
  description = "Project Location"
  default     = "us-central1"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "dataeng_448500_ecobici_ds"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "dataeng-448500-ecobici-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}
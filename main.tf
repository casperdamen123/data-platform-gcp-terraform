provider "google" {
  credentials = file("gcp_service_account_key.json")
  project = var.gcp_project_id
  region  = "us-central1"
}

// Enables needed APIs
resource "google_project_service" "project" {
  project = var.gcp_project_id
  count = length(var.api_services_to_enable)
  service = var.api_services_to_enable[count.index]
} 


// Generate raw zone dataset
resource "google_bigquery_dataset" "raw_zone" {
  dataset_id                  = var.data_zones["raw"]
  friendly_name               = "Landing Zone"
  description                 = "This dataset serves as a raw zone, containing all raw incoming data"
  location                    = "EU"
  default_table_expiration_ms = 3600000

  labels = {
    env = var.environment
  }
  
}

// Provide access to raw zone
resource "google_bigquery_dataset_access" "raw_zone_access" {
  dataset_id    = google_bigquery_dataset.raw_zone.dataset_id
  count         = length(var.dataset_owners)    
  role          = "OWNER"
  user_by_email = var.dataset_owners[count.index]
}

// Generates curated zone dataset
resource "google_bigquery_dataset" "curated_zone" {
  dataset_id                  = var.data_zones["curated"]
  friendly_name               = "Curated Zone"
  description                 = "This dataset serves as a curated zone, containing the final business data"
  location                    = "EU"
  default_table_expiration_ms = 3600000

  labels = {
    env = var.environment
  }
}

// Provide access to raw zone
resource "google_bigquery_dataset_access" "curated_zone_access" {
  dataset_id    = google_bigquery_dataset.curated_zone.dataset_id
  count         = length(var.dataset_owners)    
  role          = "OWNER"
  user_by_email = var.dataset_owners[count.index]
}

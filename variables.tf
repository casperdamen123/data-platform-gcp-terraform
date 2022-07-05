variable "gcp_project_id" {
  type        = string
  default     = "terraform-sandbox-355413"
  description = "Unique ID for the Google Cloud Project to deploy resources to"
}

variable "api_services_to_enable" {
    description = "Google APIs to enable in project"
    type = list(string)
    default = [
        "iam.googleapis.com",
        "cloudresourcemanager.googleapis.com"
    ]
}

variable "data_zones" {
    description = "Names for different BigQuery data zones"
    type = map(any)
    default = {
        "raw" = "raw_zone"
        "curated" = "curated_zone"
    }
}

variable "environment" {
    description = "Name of the environment to deploy to"
    type = string
    default = "dev"
}

variable "dataset_owners" {
    type = list(string)
    default = [
        "casper.a.damen@gmail.com",
        "casper.damen@digital-power.com"
    ]
}
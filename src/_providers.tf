terraform {
  required_version = ">= 1.0"
  required_providers {
    massdriver = {
      source  = "massdriver-cloud/massdriver"
      version = ">= 1.1.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

locals {
  project_id      = var.gcp_authentication.data.project_id
  gcp_credentials = jsonencode(var.gcp_authentication.data)
  gcp_region      = var.subnetwork.specs.gcp.region
  # locations can be multi-region or single region
  # multi-region : us-central, europe-west
  # single region: us-west1
  # by using a location, an entire region can go down without losing data or service
  # and Firestore manages that for you
  human_location_to_gcp_location = {
    # nam5 multi-region
    "US" = "us-central"
    # eur3 multi-region
    "Europe" = "europe-west"
  }
  gcp_location = lookup(local.human_location_to_gcp_location, var.gcp_location)
}

provider "google" {
  project     = local.project_id
  credentials = local.gcp_credentials
  region      = local.gcp_region
}

provider "google-beta" {
  project     = local.project_id
  credentials = local.gcp_credentials
  region      = local.gcp_region
}

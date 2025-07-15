terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.0"
    }
  }
}

# Configure the Google Provider
provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

# Enable required APIs
resource "google_project_service" "required_apis" {
  for_each = toset([
    "run.googleapis.com",
    "sqladmin.googleapis.com",
    "secretmanager.googleapis.com",
    "cloudbuild.googleapis.com",
    "containerregistry.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "compute.googleapis.com",
    "vpcaccess.googleapis.com"
  ])

  project = var.project_id
  service = each.value

  disable_dependent_services = true
  disable_on_destroy         = false
}

# Create VPC for private networking
module "vpc" {
  source = "./modules/vpc"
  
  project_id = var.project_id
  region     = var.region
  vpc_name   = "reckon-vpc"
}

# Create Cloud SQL instance
module "database" {
  source = "./modules/database"
  
  project_id     = var.project_id
  region         = var.region
  instance_name  = "reckon-${var.environment}-db"
  database_name  = "reckon_${var.environment}"
  vpc_network    = module.vpc.vpc_id
  environment    = var.environment
  
  depends_on = [google_project_service.required_apis]
}

# Create Secret Manager secrets
module "secrets" {
  source = "./modules/secrets"
  
  project_id = var.project_id
  environment = var.environment
  
  depends_on = [google_project_service.required_apis]
}

# Create Cloud Run services
module "cloud_run" {
  source = "./modules/cloud_run"
  
  project_id = var.project_id
  region     = var.region
  environment = var.environment
  
  vpc_connector = module.vpc.vpc_connector_id
  database_instance = module.database.instance_name
  
  depends_on = [
    google_project_service.required_apis,
    module.database,
    module.secrets
  ]
}

# Create service account for Cloud Run
module "service_account" {
  source = "./modules/service_account"
  
  project_id = var.project_id
  environment = var.environment
  
  depends_on = [google_project_service.required_apis]
} 
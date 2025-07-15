# Create service account for Cloud Run
resource "google_service_account" "cloud_run_sa" {
  account_id   = "reckon-cloudrun-${var.environment}"
  display_name = "Reckon Cloud Run Service Account - ${var.environment}"
  project      = var.project_id
}

# Grant Secret Manager access
resource "google_project_iam_member" "secret_manager_access" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}

# Grant Cloud SQL access
resource "google_project_iam_member" "cloud_sql_access" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}

# Grant Cloud Logging access
resource "google_project_iam_member" "logging_access" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}

# Grant Cloud Monitoring access
resource "google_project_iam_member" "monitoring_access" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}

# Grant VPC access
resource "google_project_iam_member" "vpc_access" {
  project = var.project_id
  role    = "roles/vpcaccess.user"
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
} 
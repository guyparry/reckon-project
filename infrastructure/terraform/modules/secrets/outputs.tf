output "secret_names" {
  description = "The names of all created secrets"
  value       = local.secret_names
}

output "database_url_secret_id" {
  description = "The database URL secret ID"
  value       = google_secret_manager_secret.database_url.secret_id
}

output "secret_key_secret_id" {
  description = "The secret key secret ID"
  value       = google_secret_manager_secret.secret_key.secret_id
}

output "jwt_secret_id" {
  description = "The JWT secret ID"
  value       = google_secret_manager_secret.jwt_secret.secret_id
}

output "gcp_project_id_secret_id" {
  description = "The GCP project ID secret ID"
  value       = google_secret_manager_secret.gcp_project_id.secret_id
} 
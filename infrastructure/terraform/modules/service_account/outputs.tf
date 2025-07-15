output "email" {
  description = "The service account email"
  value       = google_service_account.cloud_run_sa.email
}

output "name" {
  description = "The service account name"
  value       = google_service_account.cloud_run_sa.name
}

output "unique_id" {
  description = "The service account unique ID"
  value       = google_service_account.cloud_run_sa.unique_id
} 
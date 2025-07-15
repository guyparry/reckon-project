output "backend_service_url" {
  description = "The Cloud Run backend service URL"
  value       = google_cloud_run_v2_service.backend.uri
}

output "frontend_service_url" {
  description = "The Cloud Run frontend service URL"
  value       = google_cloud_run_v2_service.frontend.uri
}

output "backend_service_name" {
  description = "The Cloud Run backend service name"
  value       = google_cloud_run_v2_service.backend.name
}

output "frontend_service_name" {
  description = "The Cloud Run frontend service name"
  value       = google_cloud_run_v2_service.frontend.name
} 
output "vpc_id" {
  description = "The VPC ID"
  value       = google_compute_network.vpc.id
}

output "vpc_name" {
  description = "The VPC name"
  value       = google_compute_network.vpc.name
}

output "vpc_connector_id" {
  description = "The VPC connector ID"
  value       = google_vpc_access_connector.connector.id
}

output "vpc_connector_name" {
  description = "The VPC connector name"
  value       = google_vpc_access_connector.connector.name
}

output "cloudrun_subnet_id" {
  description = "The Cloud Run subnet ID"
  value       = google_compute_subnetwork.cloudrun_subnet.id
}

output "sql_subnet_id" {
  description = "The Cloud SQL subnet ID"
  value       = google_compute_subnetwork.sql_subnet.id
} 
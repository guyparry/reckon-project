output "instance_name" {
  description = "The Cloud SQL instance name"
  value       = google_sql_database_instance.instance.name
}

output "connection_name" {
  description = "The Cloud SQL connection name"
  value       = google_sql_database_instance.instance.connection_name
}

output "private_ip_address" {
  description = "The Cloud SQL private IP address"
  value       = google_sql_database_instance.instance.private_ip_address
}

output "database_name" {
  description = "The database name"
  value       = google_sql_database.database.name
}

output "user_name" {
  description = "The database user name"
  value       = google_sql_user.user.name
}

output "user_password" {
  description = "The database user password"
  value       = random_password.db_password.result
  sensitive   = true
} 
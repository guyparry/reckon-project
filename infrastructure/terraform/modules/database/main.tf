# Create Cloud SQL instance
resource "google_sql_database_instance" "instance" {
  name             = var.instance_name
  database_version = "POSTGRES_15"
  region           = var.region
  project          = var.project_id

  settings {
    tier = var.database_tier

    ip_configuration {
      ipv4_enabled    = false  # Disable public IP for security
      private_network = var.vpc_network
      require_ssl     = true
    }

    backup_configuration {
      enabled                        = var.backup_enabled
      start_time                     = "02:00"  # 2 AM backup
      point_in_time_recovery_enabled = false    # Disabled for cost savings
      transaction_log_retention_days = var.backup_retention_days
      backup_retention_settings {
        retained_backups = var.backup_retention_days
      }
    }

    maintenance_window {
      day          = 7  # Sunday
      hour         = 2  # 2 AM
      update_track = "stable"
    }

    # Disable high availability for cost savings
    availability_type = "ZONAL"

    # Minimal disk size for cost savings
    disk_size    = var.disk_size
    disk_type    = "PD_SSD"
    disk_autoresize = false  # Disable auto-resize for cost control
  }

  deletion_protection = false  # Allow deletion for hobby project
}

# Create database
resource "google_sql_database" "database" {
  name     = var.database_name
  instance = google_sql_database_instance.instance.name
  project  = var.project_id
}

# Create database user
resource "google_sql_user" "user" {
  name     = "reckon_user"
  instance = google_sql_database_instance.instance.name
  project  = var.project_id
  password = random_password.db_password.result
}

# Generate random password for database user
resource "random_password" "db_password" {
  length  = 16
  special = true
  upper   = true
  lower   = true
  numeric = true
}

# Create database connection name for Cloud Run
resource "google_sql_database_instance" "connection_name" {
  name = google_sql_database_instance.instance.connection_name
} 
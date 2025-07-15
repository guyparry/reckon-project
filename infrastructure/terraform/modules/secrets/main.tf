# Create secrets for the application
locals {
  secret_names = [
    "reckon-${var.environment}-database-url",
    "reckon-${var.environment}-secret-key",
    "reckon-${var.environment}-jwt-secret",
    "reckon-${var.environment}-gcp-project-id"
  ]
}

# Create secret for database URL
resource "google_secret_manager_secret" "database_url" {
  secret_id = "reckon-${var.environment}-database-url"
  project   = var.project_id

  replication {
    auto {}
  }
}

# Create secret for application secret key
resource "google_secret_manager_secret" "secret_key" {
  secret_id = "reckon-${var.environment}-secret-key"
  project   = var.project_id

  replication {
    auto {}
  }
}

# Create secret for JWT secret
resource "google_secret_manager_secret" "jwt_secret" {
  secret_id = "reckon-${var.environment}-jwt-secret"
  project   = var.project_id

  replication {
    auto {}
  }
}

# Create secret for GCP project ID
resource "google_secret_manager_secret" "gcp_project_id" {
  secret_id = "reckon-${var.environment}-gcp-project-id"
  project   = var.project_id

  replication {
    auto {}
  }
}

# Add initial versions to secrets (you'll need to update these with real values)
resource "google_secret_manager_secret_version" "database_url_version" {
  secret      = google_secret_manager_secret.database_url.id
  secret_data = "postgresql://user:password@localhost:5432/database"  # Placeholder
}

resource "google_secret_manager_secret_version" "secret_key_version" {
  secret      = google_secret_manager_secret.secret_key.id
  secret_data = "your-secret-key-here"  # Placeholder
}

resource "google_secret_manager_secret_version" "jwt_secret_version" {
  secret      = google_secret_manager_secret.jwt_secret.id
  secret_data = "your-jwt-secret-here"  # Placeholder
}

resource "google_secret_manager_secret_version" "gcp_project_id_version" {
  secret      = google_secret_manager_secret.gcp_project_id.id
  secret_data = var.project_id
} 
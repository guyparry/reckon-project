# Create Cloud Run backend service
resource "google_cloud_run_v2_service" "backend" {
  name     = "reckon-backend-${var.environment}"
  location = var.region
  project  = var.project_id

  template {
    scaling {
      min_instance_count = var.min_instances
      max_instance_count = var.max_instances
    }

    vpc_access {
      connector = var.vpc_connector
      egress    = "ALL_TRAFFIC"
    }

    containers {
      image = "gcr.io/${var.project_id}/reckon-backend:latest"  # Placeholder image

      resources {
        limits = {
          cpu    = var.cpu
          memory = var.memory
        }
      }

      env {
        name  = "ENVIRONMENT"
        value = var.environment
      }

      env {
        name  = "DATABASE_URL"
        value = "projects/${var.project_id}/secrets/reckon-${var.environment}-database-url/versions/latest"
        value_source {
          secret_key_ref {
            secret  = "reckon-${var.environment}-database-url"
            version = "latest"
          }
        }
      }

      env {
        name  = "SECRET_KEY"
        value = "projects/${var.project_id}/secrets/reckon-${var.environment}-secret-key/versions/latest"
        value_source {
          secret_key_ref {
            secret  = "reckon-${var.environment}-secret-key"
            version = "latest"
          }
        }
      }

      env {
        name  = "JWT_SECRET"
        value = "projects/${var.project_id}/secrets/reckon-${var.environment}-jwt-secret/versions/latest"
        value_source {
          secret_key_ref {
            secret  = "reckon-${var.environment}-jwt-secret"
            version = "latest"
          }
        }
      }

      env {
        name  = "GCP_PROJECT_ID"
        value = "projects/${var.project_id}/secrets/reckon-${var.environment}-gcp-project-id/versions/latest"
        value_source {
          secret_key_ref {
            secret  = "reckon-${var.environment}-gcp-project-id"
            version = "latest"
          }
        }
      }

      ports {
        container_port = 8000
      }
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
}

# Create Cloud Run frontend service
resource "google_cloud_run_v2_service" "frontend" {
  name     = "reckon-frontend-${var.environment}"
  location = var.region
  project  = var.project_id

  template {
    scaling {
      min_instance_count = var.min_instances
      max_instance_count = var.max_instances
    }

    containers {
      image = "gcr.io/${var.project_id}/reckon-frontend:latest"  # Placeholder image

      resources {
        limits = {
          cpu    = var.cpu
          memory = var.frontend_memory
        }
      }

      env {
        name  = "ENVIRONMENT"
        value = var.environment
      }

      env {
        name  = "VITE_API_BASE_URL"
        value = google_cloud_run_v2_service.backend.uri
      }

      ports {
        container_port = 3000
      }
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
}

# Allow unauthenticated access to frontend
resource "google_cloud_run_service_iam_member" "frontend_public" {
  location = google_cloud_run_v2_service.frontend.location
  project  = google_cloud_run_v2_service.frontend.project
  service  = google_cloud_run_v2_service.frontend.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# Allow authenticated access to backend
resource "google_cloud_run_service_iam_member" "backend_authenticated" {
  location = google_cloud_run_v2_service.backend.location
  project  = google_cloud_run_v2_service.backend.project
  service  = google_cloud_run_v2_service.backend.name
  role     = "roles/run.invoker"
  member   = "allUsers"  # Change this to specific service account for production
} 
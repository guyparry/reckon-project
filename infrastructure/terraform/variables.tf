variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for resources"
  type        = string
  default     = "us-central1"
}

variable "environment" {
  description = "Environment (production only)"
  type        = string
  default     = "production"
  
  validation {
    condition     = contains(["production"], var.environment)
    error_message = "Environment must be 'production'."
  }
}

variable "database_tier" {
  description = "Database machine type (optimized for cost)"
  type        = string
  default     = "db-f1-micro"  # Smallest instance for cost savings
}

variable "database_disk_size" {
  description = "Database disk size in GB"
  type        = number
  default     = 10  # Minimal size for hobby project
}

variable "cloud_run_cpu" {
  description = "Cloud Run CPU allocation"
  type        = string
  default     = "1"  # Shared CPU for cost savings
}

variable "cloud_run_memory" {
  description = "Cloud Run memory allocation"
  type        = string
  default     = "512Mi"  # Minimal memory for cost savings
}

variable "cloud_run_max_instances" {
  description = "Maximum Cloud Run instances"
  type        = number
  default     = 5  # Low max for hobby project
}

variable "cloud_run_min_instances" {
  description = "Minimum Cloud Run instances"
  type        = number
  default     = 0  # Scale to zero for cost savings
}

variable "enable_high_availability" {
  description = "Enable high availability for database"
  type        = bool
  default     = false  # Disabled for cost savings
}

variable "backup_enabled" {
  description = "Enable database backups"
  type        = bool
  default     = true
}

variable "backup_retention_days" {
  description = "Database backup retention in days"
  type        = number
  default     = 7  # Minimal retention for cost savings
} 
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "instance_name" {
  description = "The Cloud SQL instance name"
  type        = string
}

variable "database_name" {
  description = "The database name"
  type        = string
}

variable "vpc_network" {
  description = "The VPC network ID"
  type        = string
}

variable "environment" {
  description = "The environment"
  type        = string
}

variable "database_tier" {
  description = "The database machine type"
  type        = string
  default     = "db-f1-micro"  # Smallest instance for cost savings
}

variable "disk_size" {
  description = "The database disk size in GB"
  type        = number
  default     = 10  # Minimal size for hobby project
}

variable "backup_enabled" {
  description = "Enable database backups"
  type        = bool
  default     = true
}

variable "backup_retention_days" {
  description = "Backup retention in days"
  type        = number
  default     = 7  # Minimal retention for cost savings
} 
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "environment" {
  description = "The environment"
  type        = string
}

variable "vpc_connector" {
  description = "The VPC connector ID"
  type        = string
}

variable "database_instance" {
  description = "The database instance name"
  type        = string
}

variable "cpu" {
  description = "CPU allocation"
  type        = string
  default     = "1"  # Shared CPU for cost savings
}

variable "memory" {
  description = "Memory allocation for backend"
  type        = string
  default     = "512Mi"  # Minimal memory for cost savings
}

variable "frontend_memory" {
  description = "Memory allocation for frontend"
  type        = string
  default     = "256Mi"  # Minimal memory for frontend
}

variable "min_instances" {
  description = "Minimum number of instances"
  type        = number
  default     = 0  # Scale to zero for cost savings
}

variable "max_instances" {
  description = "Maximum number of instances"
  type        = number
  default     = 5  # Low max for hobby project
} 
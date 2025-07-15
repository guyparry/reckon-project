output "project_id" {
  description = "The GCP project ID"
  value       = var.project_id
}

output "region" {
  description = "The GCP region"
  value       = var.region
}

output "environment" {
  description = "The environment"
  value       = var.environment
}

output "database_instance_name" {
  description = "The Cloud SQL instance name"
  value       = module.database.instance_name
}

output "database_connection_name" {
  description = "The Cloud SQL connection name"
  value       = module.database.connection_name
}

output "database_private_ip_address" {
  description = "The Cloud SQL private IP address"
  value       = module.database.private_ip_address
}

output "backend_service_url" {
  description = "The Cloud Run backend service URL"
  value       = module.cloud_run.backend_service_url
}

output "frontend_service_url" {
  description = "The Cloud Run frontend service URL"
  value       = module.cloud_run.frontend_service_url
}

output "vpc_connector_id" {
  description = "The VPC connector ID"
  value       = module.vpc.vpc_connector_id
}

output "service_account_email" {
  description = "The service account email"
  value       = module.service_account.email
}

output "secret_names" {
  description = "The Secret Manager secret names"
  value       = module.secrets.secret_names
}

output "deployment_instructions" {
  description = "Instructions for deploying the application"
  value = <<-EOT
    ========================================
    DEPLOYMENT INSTRUCTIONS
    ========================================
    
    Backend Service URL: ${module.cloud_run.backend_service_url}
    Frontend Service URL: ${module.cloud_run.frontend_service_url}
    
    Database Connection:
    - Instance: ${module.database.instance_name}
    - Connection Name: ${module.database.connection_name}
    - Private IP: ${module.database.private_ip_address}
    
    Next Steps:
    1. Set up your database secrets in Secret Manager
    2. Deploy your backend container to Cloud Run
    3. Deploy your frontend container to Cloud Run
    4. Configure your CI/CD pipeline
    
    Cost Optimization:
    - Services scale to zero when not in use
    - Using smallest database instance (db-f1-micro)
    - Minimal resource allocation for hobby project
    - Estimated cost: $20-40/month for this setup
    
    ========================================
  EOT
} 
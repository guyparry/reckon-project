# Staging Environment Configuration
# Optimized for cost savings and hobby project usage

project_id = "your-staging-project-id"  # Replace with your actual project ID
region     = "us-central1"
environment = "staging"

# Database settings (minimal for staging)
database_tier = "db-f1-micro"  # Smallest instance
database_disk_size = 10        # Minimal disk size
backup_retention_days = 3      # Minimal backup retention

# Cloud Run settings (scale to zero for cost savings)
cloud_run_cpu = "1"            # Shared CPU
cloud_run_memory = "256Mi"     # Minimal memory
cloud_run_max_instances = 2    # Very low max for staging
cloud_run_min_instances = 0    # Scale to zero

# High availability disabled for cost savings
enable_high_availability = false 
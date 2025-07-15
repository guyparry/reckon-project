# Production Environment Configuration
# Optimized for reliability while maintaining cost efficiency

project_id = "your-production-project-id"  # Replace with your actual project ID
region     = "us-central1"
environment = "production"

# Database settings (slightly more resources for production)
database_tier = "db-f1-micro"  # Still using smallest instance for cost
database_disk_size = 20        # Slightly larger disk
backup_retention_days = 7      # Weekly backups

# Cloud Run settings (minimal but reliable)
cloud_run_cpu = "1"            # Shared CPU
cloud_run_memory = "512Mi"     # More memory for production
cloud_run_max_instances = 5    # Low max for hobby project
cloud_run_min_instances = 1    # Keep one instance warm

# High availability disabled for cost savings
enable_high_availability = false 
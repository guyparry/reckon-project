# Production Environment Configuration
# Optimized for reliability while maintaining cost efficiency

project_id = "model-ruler-466314-d8"  # Your actual project ID (this doesn't change)
region     = "us-central1"
environment = "production"

# Database settings (optimized for cost)
database_tier = "db-f1-micro"  # Smallest instance for cost savings
database_disk_size = 20        # Adequate disk size
backup_retention_days = 7      # Weekly backups

# Cloud Run settings (minimal but reliable)
cloud_run_cpu = "1"            # Shared CPU
cloud_run_memory = "512Mi"     # Adequate memory
cloud_run_max_instances = 5    # Low max for hobby project
cloud_run_min_instances = 1    # Keep one instance warm

# High availability disabled for cost savings
enable_high_availability = false 
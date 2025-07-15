# Create VPC
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  project                 = var.project_id
}

# Create subnet for Cloud Run
resource "google_compute_subnetwork" "cloudrun_subnet" {
  name          = "${var.vpc_name}-cloudrun"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc.id
  project       = var.project_id

  # Enable flow logs for debugging
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling       = 0.5
    metadata           = "INCLUDE_ALL_METADATA"
  }
}

# Create subnet for Cloud SQL
resource "google_compute_subnetwork" "sql_subnet" {
  name          = "${var.vpc_name}-sql"
  ip_cidr_range = "10.0.2.0/24"
  region        = var.region
  network       = google_compute_network.vpc.id
  project       = var.project_id

  # Enable flow logs for debugging
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling       = 0.5
    metadata           = "INCLUDE_ALL_METADATA"
  }
}

# Create VPC connector for Cloud Run
resource "google_vpc_access_connector" "connector" {
  name          = "${var.vpc_name}-connector"
  region        = var.region
  project       = var.project_id
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.8.0.0/28"  # Small range for cost savings
  machine_type  = "e2-micro"     # Smallest machine type
  min_instances = 0              # Scale to zero
  max_instances = 2              # Minimal instances for cost savings
}

# Create firewall rule to allow Cloud Run to access Cloud SQL
resource "google_compute_firewall" "cloudrun_to_sql" {
  name    = "${var.vpc_name}-cloudrun-to-sql"
  network = google_compute_network.vpc.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["5432"]  # PostgreSQL port
  }

  source_ranges = ["10.0.1.0/24"]  # Cloud Run subnet
  target_tags   = ["cloud-sql"]
}

# Create Cloud NAT for outbound internet access
resource "google_compute_router" "router" {
  name    = "${var.vpc_name}-router"
  region  = var.region
  network = google_compute_network.vpc.id
  project = var.project_id
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.vpc_name}-nat"
  router                            = google_compute_router.router.name
  region                            = var.region
  project                           = var.project_id
  nat_ip_allocate_option            = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
} 
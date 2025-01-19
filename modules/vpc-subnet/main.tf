# this is module vpc-subnet by gcp

resource "google_compute_network" "vpc-network" {
  name = var.vpc_name
  project = var.project
  auto_create_subnetworks = false
  
}

resource "google_compute_firewall" "vpc-firewall" {
  name    = var.firewall_name
  network = google_compute_network.vpc-network.name
  project = var.project

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  # allow specific ip ranges
  source_ranges = var.allow_source_ranges
}

resource "google_compute_subnetwork" "vpc-subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = var.vpc_name
  project       = var.project

  depends_on = [google_compute_network.vpc-network]
}
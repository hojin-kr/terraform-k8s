output "name" {
  description = "The name of the subnet"
  value       = google_compute_subnetwork.vpc-subnet.name
}

output "ip_cidr_range" {
  description = "The IP CIDR range of the subnet"
  value       = google_compute_subnetwork.vpc-subnet.ip_cidr_range
}

output "region" {
  description = "The region in which the subnet is located"
  value       = google_compute_subnetwork.vpc-subnet.region
}

output "network" {
  description = "The network in which the subnet is located"
  value       = google_compute_subnetwork.vpc-subnet.network
}

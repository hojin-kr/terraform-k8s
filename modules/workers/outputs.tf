output "name" {
  description = "The name of the instance"
  value       = google_compute_instance.control-plane.name
}

output "project" {
  description = "The project in which the resource belongs"
  value       = google_compute_instance.control-plane.project
}

output "zone" {
    description = "The zone in which to create the instance"
    value       = google_compute_instance.control-plane.zone
}

output "gcloud-ssh-command" {
    description = "The command to ssh into the instance by gcloud"
    value       = "gcloud compute ssh --zone=${google_compute_instance.control-plane.zone} ${google_compute_instance.control-plane.name}"
}
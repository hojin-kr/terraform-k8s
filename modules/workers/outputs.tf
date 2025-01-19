output "name" {
  description = "The name of the instance"
  value = google_compute_instance_group_manager.worker.name
}

output "project" {
  description = "The project in which the resource belongs"
  value = google_compute_instance_group_manager.worker.project
}

output "zone" {
  description = "The zone in which to create the instance"
  value = google_compute_instance_group_manager.worker.zone
}

output "gcloud-ssh-command" {
  description = "The command to ssh into the instance by gcloud"
  value = "gcloud compute ssh --zone=${google_compute_instance_group_manager.worker.zone} ${google_compute_instance_group_manager.worker.name}"
}

output "instance-template" {
  description = "The instance template used by the instance group manager"
  value = google_compute_instance_template.worker.name
}

output "autoscaler" {
  description = "The autoscaler used by the instance group manager"
  value = google_compute_autoscaler.worker.name
}

output "subnetwork" {
  description = "The subnetwork in which the instance is located"
  value = google_compute_instance_template.worker.network_interface.0.subnetwork
}


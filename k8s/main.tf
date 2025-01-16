module "control-plane" {
  source = "../modules/control-plane"

  name         = var.control-plane-name
  project      = var.control-plane-project
  zone         = var.control-plane-zone
  machine_type = var.control-plane-machine_type
  image        = var.control-plane-image
  size         = var.control-plane-size
  subnetwork   = var.control-plane-subnetwork
  labels       = var.control-plane-labels
}

module "workers" {
  source = "../modules/workers"

  name         = var.workers-name
  project      = var.workers-project
  zone         = var.workers-zone
  machine_type = var.workers-machine_type
  image        = var.workers-image
  size         = var.workers-size
  subnetwork   = var.workers-subnetwork
  labels       = var.workers-labels
}

output "control-plane-name" {
  description = "The name of the control plane instance"
  value       = module.control-plane.name
}

output "control-plane-project" {
  description = "The project in which the control plane instance belongs"
  value       = module.control-plane.project
}

output "control-plane-zone" {
  description = "The zone in which the control plane instance is located"
  value       = module.control-plane.zone
}

output "control-plane-gcloud-ssh-command" {
  description = "The command to ssh into the control plane instance by gcloud"
  value       = module.control-plane.gcloud-ssh-command
}

output "workers-name" {
  description = "The name of the workers instance"
  value       = module.workers.name
}

output "workers-project" {
  description = "The project in which the workers instance belongs"
  value       = module.workers.project
}

output "workers-zone" {
  description = "The zone in which the workers instance is located"
  value       = module.workers.zone
}

output "workers-gcloud-ssh-command" {
  description = "The command to ssh into the workers instance by gcloud"
  value       = module.workers.gcloud-ssh-command
}

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
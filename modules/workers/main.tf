
resource "google_compute_autoscaler" "worker" {
  project = var.project
  name = var.name
  zone = var.zone

  target = google_compute_instance_group_manager.worker.id

  autoscaling_policy {
    max_replicas = var.max_replicas
    min_replicas = var.min_replicas

    mode = "ON"
  }
}

resource "google_compute_instance_template" "worker" {
  name = var.name
  project = var.project
  machine_type = var.machine_type
  region = var.region

  disk {
    source_image = var.image
    disk_size_gb = var.size
  }

  network_interface {
    subnetwork = var.subnetwork
    subnetwork_project = var.project
  }

  labels = var.labels
}

resource "google_compute_target_pool" "worker" {
  project = var.project
  name = var.name
  region = var.region
}

resource "google_compute_instance_group_manager" "worker" {
  project = var.project
  name = var.name
  zone = var.zone

  version {
    instance_template = google_compute_instance_template.worker.id
    name = var.name
  }

  target_pools = [google_compute_target_pool.worker.id]
  base_instance_name = var.name
}

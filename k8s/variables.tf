variable "control-plane-name" {
  description = "The name of the instance"
  type        = string
  default = "control-plane01"
}

variable "control-plane-project" {
  description = "The project in which the resource belongs"
  type        = string
  default = "etcd-389303"
}

variable "control-plane-image" {
  description = "The image to use for the instance"
  type        = string
  default = "projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20250112"
}

variable "control-plane-size" {
  description = "The size of the boot disk"
  type        = number
  default = 10
}

variable "control-plane-subnetwork" {
  description = "The subnetwork in which to create the instance"
  type        = string
  default = "projects/etcd-389303/regions/us-central1/subnetworks/default"
}

variable "control-plane-zone" {
  description = "The zone in which to create the instance"
  type        = string
  default = "us-central1-a"
}

variable "control-plane-machine_type" {
  description = "The machine type for the instance"
  type        = string
  default = "e2-standard-2"
}

variable "control-plane-labels" {
  description = "The labels to apply to the instance"
  type        = map(string)
  default = {
    goog-ec-src = "vm_add-tf"
    env = "test"
    role = "control-plane"
  }
}

variable "workers-name" {
  description = "The name of the instance"
  type        = string
  default = "worker01"
}

variable "workers-project" {
  description = "The project in which the resource belongs"
  type        = string
  default = "etcd-389303"
}

variable "workers-image" {
  description = "The image to use for the instance"
  type        = string
  default = "projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20250112"
}

variable "workers-size" {
  description = "The size of the boot disk"
  type        = number
  default = 10
}

variable "workers-subnetwork" {
  description = "The subnetwork in which to create the instance"
  type        = string
  default = "projects/etcd-389303/regions/us-central1/subnetworks/default"
}

variable "workers-zone" {
  description = "The zone in which to create the instance"
  type        = string
  default = "us-central1-a"
}

variable "workers-machine_type" {
  description = "The machine type for the instance"
  type        = string
  default = "e2-standard-2"
}

variable "workers-labels" {
  description = "The labels to apply to the instance"
  type        = map(string)
  default = {
    goog-ec-src = "vm_add-tf"
    env = "test"
    role = "worker"
  }
}
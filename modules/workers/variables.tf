variable "name" {
  description = "The name of the instance"
  type        = string
  default = "tester"
}

variable "project" {
  description = "The project in which the resource belongs"
  type        = string
  default = "etcd-389303"
}

variable "image" {
  description = "The image to use for the instance"
  type        = string
  default = "projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20250112"
}

variable "size" {
  description = "The size of the boot disk"
  type        = number
  default = 10
}

variable "subnetwork" {
  description = "The subnetwork in which to create the instance"
  type        = string
  default = "projects/etcd-389303/regions/us-central1/subnetworks/default"
}

variable "zone" {
  description = "The zone in which to create the instance"
  type        = string
  default = "us-central1-a"
}

variable "machine_type" {
  description = "The machine type for the instance"
  type        = string
  default = "e2-standard-2"
}

variable "labels" {
  description = "The labels to apply to the instance"
  type        = map(string)
  default = {
    goog-ec-src = "vm_add-tf"
    env = "test"
  }
}

variable "min_replicas" {
  description = "The minimum number of replicas"
  type        = number
  default = 1
}

variable "max_replicas" {
  description = "The maximum number of replicas"
  type        = number
  default = 1
  
}

variable "region" {
  description = "The region in which to create the instance"
  type        = string
  default = "us-central1"
  
}
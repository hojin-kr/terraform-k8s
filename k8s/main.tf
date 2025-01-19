# This is the main Terraform configuration file for the Kubernetes cluster.
module "vpc-subnet" {
  source = "../modules/vpc-subnet"

  project       = var.vpc-subnet-project
  vpc_name      = var.vpc-subnet-vpc-name
  ip_cidr_range = var.vpc-subnet-ip_cidr_range
  region        = var.vpc-subnet-region
  subnet_name   = var.vpc-subent-subnet-name
}

module "control-plane" {
  source = "../modules/control-plane"

  name         = var.control-plane-name
  project      = var.control-plane-project
  zone         = var.control-plane-zone
  machine_type = var.control-plane-machine_type
  image        = var.control-plane-image
  size         = var.control-plane-size
  subnetwork   = module.vpc-subnet.name
  labels       = var.control-plane-labels

  depends_on = [module.vpc-subnet]
}

module "workers" {
  source = "../modules/workers"

  name         = var.workers-name
  project      = var.workers-project
  zone         = var.workers-zone
  machine_type = var.workers-machine_type
  image        = var.workers-image
  size         = var.workers-size
  subnetwork   = module.vpc-subnet.name
  labels       = var.workers-labels

  depends_on = [module.control-plane]
}
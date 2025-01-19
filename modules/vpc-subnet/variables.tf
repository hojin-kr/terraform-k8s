variable "vpc_name" {
  description = "The name of the instance"
  type        = string
  default = "dev-terraform-practice"
}

variable "subnet_name" {
  description = "The name of the instance"
  type        = string
  default = "dev-terraform-practice-k8s"
}

variable "project" {
  description = "The project in which the resource belongs"
  type        = string
  default = "etcd-389303"
}

variable "region" {
    description = "The region in which to create the instance"
    type        = string
    default = "us-central1" 
}

variable "ip_cidr_range" {
    description = "The IP CIDR range for the subnet"
    type        = string
    default = "10.127.0.0/20"
}
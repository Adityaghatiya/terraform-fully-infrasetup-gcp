variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "vpc_self_link" {
  description = "Self link of the VPC network"
  type        = string
}

variable "subnets" {
  description = "List of subnet configurations"
  type = list(object({
    name          = string
    ip_cidr_range = string
    region        = string
  }))
}

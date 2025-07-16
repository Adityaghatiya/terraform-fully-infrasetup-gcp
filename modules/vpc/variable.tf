variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "network_name" {
  type        = string
  description = "Name of the VPC network"
}

variable "vpc_description" {
  type        = string
  description = "This is the custom VPC description for the dev environment"
  default     = "This is the required custom VPC"
}

variable "subnet_type" {
  type        = string
  description = "This is required subnet type"
  default     = "false"
}

variable "routing_md" {
  type        = string
  default     = "GLOBAL"
  description = "The network routing mode (default 'GLOBAL')"
}

variable "enable_ipv6_ula" {
  type        = bool
  description = "Enable IPv6 ULA (permanent change, cannot be undone)"
  default     = false
}

variable "mtu" {
  type        = number
  description = "The network MTU (0 means unset - defaults to 1460)"
  default     = 0
}

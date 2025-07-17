variable "autopilot_cluster" {
  description = "List of GKE Autopilot clusters"
  type = list(object({
    name                      = string
    location                  = string
    enterprise_config         = object({ desired_tier = string })   # Optional, or use null
    deletion_protection       = optional(bool, false)
    cluster_ipv4_cidr_block   = string
    services_ipv4_cidr_block  = string
    subnetwork=string
  }))
}
variable "network"{
  type=string
  description="choose the vpc where you want to deploy it."
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

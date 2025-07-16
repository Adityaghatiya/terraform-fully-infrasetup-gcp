variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "firewall_rules" {
  description = "List of dynamic firewall rules"
  type = list(object({
    name          = string
    network       = string
    direction     = string
    source_ranges = list(string)
    allow = list(object({
      protocol = string
      ports    = list(string)
    }))
  }))
}

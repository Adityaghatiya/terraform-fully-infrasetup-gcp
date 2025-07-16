variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "nats" {
  description = "List of Cloud NAT gateways"
  type = list(object({
    name                                = string
    router_name                         = string
    region                              = string
    nat_ip_allocate_option              = string # "AUTO_ONLY" or "MANUAL_ONLY"
    nat_ips                             = optional(list(string), []) # Used only if MANUAL_ONLY
    source_subnetwork_ip_ranges_to_nat  = string # e.g., "ALL_SUBNETWORKS_ALL_IP_RANGES" or "LIST_OF_SUBNETWORKS"
    subnetworks = optional(list(object({
      name                    = string
      source_ip_ranges_to_nat = list(string)
    })), null)
  }))
}

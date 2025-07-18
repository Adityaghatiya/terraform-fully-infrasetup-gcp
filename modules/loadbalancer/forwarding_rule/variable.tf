variable "forwarding_rules" {
  description = "List of forwarding rules"
  type = list(object({
    name                  = string
    target_proxy          = string
    port_range            = string
    load_balancing_scheme = string
    ip_protocol           = string
    ip_address            = string
  }))
}

variable "backends" {
  type = list(object({
    name                  = string
    protocol              = string
    port_name             = string
    load_balancing_scheme = string
    timeout_sec           = number
    enable_cdn            = bool
    health_check          = string
    backend_group         = string
  }))
}

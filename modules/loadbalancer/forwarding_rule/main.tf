resource "google_compute_global_forwarding_rule" "fwd_rule" {
  for_each = { for rule in var.forwarding_rules : rule.name => rule }

  name                  = each.value.name
  target                = each.value.target_proxy
  port_range            = each.value.port_range
  load_balancing_scheme = each.value.load_balancing_scheme
  ip_protocol           = each.value.ip_protocol
  ip_address            = each.value.ip_address
}

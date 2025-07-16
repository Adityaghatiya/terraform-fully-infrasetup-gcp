#ref:- https://registry.terraform.io/providers/hashicorp/google/4.2.0/docs/resources/compute_firewall
resource "google_compute_firewall" "rules" {
  for_each = { for rule in var.firewall_rules : rule.name => rule }

  name    = each.value.name
  network = each.value.network
  project = var.project_id

  direction     = each.value.direction
  source_ranges = each.value.source_ranges

  dynamic "allow" {
    for_each = each.value.allow
    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }
}

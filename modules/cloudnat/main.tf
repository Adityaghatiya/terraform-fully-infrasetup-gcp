resource "google_compute_router_nat" "nat" {
  for_each = { for n in var.nats : n.name => n }

  name       = each.value.name
  router     = each.value.router_name
  region     = each.value.region
  project    = var.project_id

  nat_ip_allocate_option             = lookup(each.value, "nat_ip_allocate_option", "AUTO_ONLY")
  source_subnetwork_ip_ranges_to_nat = each.value.source_subnetwork_ip_ranges_to_nat

  dynamic "subnetwork" {
    for_each = (
      each.value.source_subnetwork_ip_ranges_to_nat == "LIST_OF_SUBNETWORKS" && 
      each.value.subnetworks != null
    ) ? each.value.subnetworks : []

    content {
      name                    = subnetwork.value.name
      source_ip_ranges_to_nat = subnetwork.value.source_ip_ranges_to_nat
    }
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

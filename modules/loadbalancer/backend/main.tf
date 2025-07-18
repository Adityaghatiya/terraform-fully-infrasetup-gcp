# ref:- https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_service

resource "google_compute_backend_service" "backend" {
  for_each              = { for b in var.backends : b.name => b }
  name                  = each.value.name
  protocol              = each.value.protocol
  port_name             = each.value.port_name
  load_balancing_scheme = each.value.load_balancing_scheme
  timeout_sec           = each.value.timeout_sec
  enable_cdn            = each.value.enable_cdn
  health_checks         = [each.value.health_check]

  backend {
    group = each.value.backend_group
  }
}

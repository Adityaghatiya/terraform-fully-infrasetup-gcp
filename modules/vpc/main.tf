resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  description                               = var.vpc_description
  auto_create_subnetworks = var.subnet_type
  project                 = var.project_id
  routing_mode            = var.routing_md
  mtu                     = var.mtu
  enable_ula_internal_ipv6                  = var.enable_ipv6_ula
}

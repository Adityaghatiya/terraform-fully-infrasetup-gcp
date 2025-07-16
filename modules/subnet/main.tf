#ref:- https://registry.terraform.io/providers/hashicorp/google/3.86.0/docs/resources/compute_subnetwork
resource "google_compute_subnetwork" "subnets" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  name            = each.value.name
  ip_cidr_range   = each.value.ip_cidr_range
  region          = each.value.region
  network         = var.vpc_self_link
  project         = var.project_id
}

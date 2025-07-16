#ref:- https://github.com/terraform-google-modules/terraform-google-cloud-nat/blob/main/main.tf

resource "google_compute_router" "router" {
  for_each = { for r in var.routers : r.name => r }

  name    = each.value.name
  network = each.value.vpc_self_link
  region  = each.value.region
  project = var.project_id
}

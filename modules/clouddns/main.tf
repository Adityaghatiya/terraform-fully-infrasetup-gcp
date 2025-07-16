# ref:- https://github.com/terraform-google-modules/terraform-google-cloud-nat/blob/main/main.tf
#ref:- https://registry.terraform.io/modules/terraform-google-modules/cloud-nat/google/4.0.0/examples/advanced
resource "google_dns_managed_zone" "zones" {
  for_each = { for zone in var.dns_zones : zone.name => zone }

  name        = each.value.name
  dns_name    = each.value.dns_name
  description = each.value.description
  project     = var.project_id
  visibility  = each.value.visibility

  dynamic "private_visibility_config" {
    for_each = each.value.visibility == "private" ? [1] : []
    content {
      dynamic "networks" {
        for_each = each.value.private_networks
        content {
          network_url = networks.value
        }
      }
    }
  }
}

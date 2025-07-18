resource "google_compute_url_map" "url_map" {
  for_each        = { for map in var.url_maps : map.name => map }
  name            = each.value.name
  default_service = each.value.default_backend
}

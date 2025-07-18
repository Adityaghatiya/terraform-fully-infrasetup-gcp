output "url_map_self_links" {
  value = { for k, v in google_compute_url_map.url_map : k => v.self_link }
}

resource "google_compute_target_http_proxy" "proxy" {
  for_each = { for proxy in var.http_proxies : proxy.name => proxy }

  name    = each.value.name
  url_map = each.value.url_map
}

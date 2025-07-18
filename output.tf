output "http_proxy_self_links" {
  value = {
    for k, v in module.target_proxy.http_proxies : k => v.self_link
  }
}

variable "http_proxies" {
  type = list(object({
    name    = string
    url_map = string
  }))
}

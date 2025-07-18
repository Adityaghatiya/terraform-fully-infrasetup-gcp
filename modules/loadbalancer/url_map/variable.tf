variable "url_maps" {
  type = list(object({
    name             = string
    default_backend  = string
  }))
}

variable "log_sink" {
  type = list(object({
    name        = string
    destination = string
    disabled    = optional(bool)
    filter      = optional(string)
    exclusions  = optional(list(object({
      name        = string
      description = string
      filter      = string
    })))
  }))
}

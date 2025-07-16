variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "dns_zones" {
  description = "List of Cloud DNS zones to create"
  type = list(object({
    name              = string
    dns_name          = string
    description       = string
    visibility        = string # "public" or "private"
    private_networks  = optional(list(string), []) # only used if visibility is private
  }))
}

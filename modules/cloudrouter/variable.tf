variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "routers" {
  description = "List of routers to create"
  type = list(object({
    name          = string
    vpc_self_link = string
    region        = string
  }))
}

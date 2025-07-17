variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "buckets" {
  description = "List of buckets to create"
  type = list(object({
    name                        = string
    location                    = string
    storage_class               = string
    force_destroy               = bool
    versioning                  = bool
    uniform_bucket_level_access = bool
    labels                      = map(string)
    lifecycle_rules = optional(list(object({
      action = object({
        type          = string
        storage_class = optional(string)
      })
      condition = object({
        age                = optional(number)
        created_before     = optional(string)
        with_state         = optional(string)
        num_newer_versions = optional(number)
      })
    })), [])
  }))
}

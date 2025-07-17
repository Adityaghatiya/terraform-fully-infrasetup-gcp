
 variable "instance_group" {
  description = "Instance group configurations"
  type = list(object({
    name               = string
    base_instance_name = string
    zone               = string
    instance_template  = string
    description        = string
    metadata = object({
      metadata_key = string
    })
    labels = object({
      label_key = string
    })
    #target_pools = string
    target_size  = number
    named_port = object({
      name = string
      port = number
    })
    auto_healing_policies = object({
      health_check      = string  # name from the `autohealing` variable
      initial_delay_sec = number
    })
  }))
}

variable "instance_group" {
  description = "Instance group configurations"
  type = list(object({
    name               = string
    base_instance_name = string
    zone               = string
    instance_template  = string
    description        = string
    target_size        = number

    metadata = map(string)
    labels   = map(string)

    named_port = object({
      name = string
      port = number
    })

    auto_healing_policies = object({
      health_check      = string
      initial_delay_sec = number
    })
  }))
}
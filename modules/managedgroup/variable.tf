
variable "instance_group" {
  description = "Instance group configurations"
  type = list(object({
    name               = string
    base_instance_name = string
    zone               = string
    instance_template  = string
    description        = string
    target_size        = number

    metadata = map(string) #all instance config attributes Isko is way me likhna padega kyoki vo attribut is loop ke sath support nahi #kr raha
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
variable "project_id"{
  type=string
  description="template create in particular project "
}

variable "templates" {
  description = "List of instance templates"
  type = list(object({
    name                 = string
    description          = string
    tags                 = list(string)
    labels               = map(string)
    instance_description = string
    machine_type         = string
    project_id           = string
    region               = string

    disks = list(object({
      source_image      = string
      auto_delete       = bool
      boot              = bool
      resource_policies = list(string)
    }))

    scheduling = object({
      automatic_restart   = bool
      on_host_maintenance = string
    })

    network_interfaces = list(object({
      network    = string
      subnetwork = string
    }))

    service_account = object({
      email  = string
      scopes = list(string)
    })
  }))
}

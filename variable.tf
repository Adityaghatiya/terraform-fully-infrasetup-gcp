variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "network_name" {
  type = string
}

variable "vpc_description" {
  type = string
}

variable "subnet_type" {
  type = string
}

variable "routing_md" {
  type = string
}

variable "enable_ipv6_ula" {
  type = bool
}

variable "mtu" {
  type = number
}

variable "subnets" {
  description = "Subnets to create"
  type = list(object({
    name          = string
    ip_cidr_range = string
    region        = string
  }))
}

variable "firewall_rules" {
  description = "Firewall rules to create"
  type = list(object({
    name          = string
    #network       = string
    direction     = string
    source_ranges = list(string)
    allow = list(object({
      protocol = string
      ports    = list(string)
    }))
  }))
}

/*variable "routers" {
  type = list(object({
    name          = string
    vpc_self_link = string
    region        = string
  }))
}
/*
variable "nats" {
  type = list(object({
    name                                = string
    router_name                         = string
    region                              = string
    source_subnetwork_ip_ranges_to_nat  = string
    subnetworks = optional(list(object({
      name                    = string
      source_ip_ranges_to_nat = list(string)
    })))
  }))
}

/*
variable "dns_zones" {
  type = list(object({
    name              = string
    dns_name          = string
    description       = string
    visibility        = string
    private_networks  = optional(list(string), [])
  }))
}
*/
variable "nats" {
  description = "List of NAT configurations"
  type = list(object({
    name                                = string
    router_name                         = string
    region                              = string
    source_subnetwork_ip_ranges_to_nat  = string
    nat_ip_allocate_option              = optional(string)
    nat_ips                             = optional(list(string))
    subnetworks = optional(list(object({
      name                    = string
      source_ip_ranges_to_nat = list(string)
    })))
  }))
}

variable "buckets" {
  description = "List of GCS buckets to create"
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
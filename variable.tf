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
    network       = string
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
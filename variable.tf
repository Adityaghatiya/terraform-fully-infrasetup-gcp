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

variable "templates" {
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

variable "autopilot_cluster" {
  description = "List of GKE Autopilot clusters"
  type = list(object({
    name                      = string
    location                  = string
    enterprise_config         = object({ desired_tier = string })   # Optional, or use null
    deletion_protection       = optional(bool, false)
    cluster_ipv4_cidr_block   = string
    services_ipv4_cidr_block  = string
    subnetwork=string
  }))
}

variable "autohealing" {
  default     = null
  description = "Health check configurations"
  type = list(object({
    name                = string
    check_interval_sec  = number
    timeout_sec         = number
    healthy_threshold   = number
    unhealthy_threshold = number
    request_path        = string
    port                = number
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


variable "backends" {
  type = list(object({
    name                  = string
    protocol              = string
    port_name             = string
    load_balancing_scheme = string
    timeout_sec           = number
    enable_cdn            = bool
    health_check          = string
    backend_group         = string
  }))
}

variable "staticip" {
  description = "List of static IPs to reserve"
  type = list(object({
    name        = string
    description = string
  }))
}

variable "http_proxies" {
  type = list(object({
    name    = string
    url_map = string
  }))
}

variable "url_maps" {
  type = list(object({
    name             = string
    default_backend  = string
  }))
}

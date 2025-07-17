#ref:- https://registry.terraform.io/providers/hashicorp/google-beta/4.51.0/docs/resources/compute_instance_template

resource "google_compute_instance_template" "templates" {
  for_each = { for template in var.templates : template.name => template }

  name                 = each.value.name
  description          = each.value.description
  tags                 = each.value.tags
  labels               = each.value.labels
  instance_description = each.value.instance_description
  machine_type         = each.value.machine_type
  project              = var.project_id
  region               = each.value.region

  dynamic "disk" {
    for_each = each.value.disks != null ? each.value.disks : []
    content {
      source_image      = disk.value.source_image
      auto_delete       = disk.value.auto_delete
      boot              = disk.value.boot
      resource_policies = disk.value.resource_policies
    }
  }

  dynamic "scheduling" {
    for_each = each.value.scheduling != null ? [each.value.scheduling] : []
    content {
      automatic_restart   = scheduling.value.automatic_restart
      on_host_maintenance = scheduling.value.on_host_maintenance
    }
  }

  dynamic "network_interface" {
    for_each = each.value.network_interfaces != null ? each.value.network_interfaces : []
    content {
      network    = network_interface.value.network
      subnetwork = network_interface.value.subnetwork
    }
  }

  dynamic "service_account" {
    for_each = each.value.service_account != null ? [each.value.service_account] : []
    content {
      email  = service_account.value.email
      scopes = service_account.value.scopes
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

/*
resource "google_compute_instance_group_manager" "instance_group_manager" {
  name               = "instance-group-manager"
  instance_template  = google_compute_instance_template.instance_template.id
  base_instance_name = "instance-group-manager"
  zone               = "us-central1-f"
  target_size        = "1"
}
*/
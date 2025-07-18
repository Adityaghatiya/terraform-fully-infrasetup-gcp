#ref:- https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_group_manager.html


#for managed instance group
resource "google_compute_instance_group_manager" "instance_group" {
  for_each={for igm in var.instance_group:igm.name=>igm}
  name = each.value.name

  base_instance_name =  each.value.base_instance_name
  zone               = each.value.zone

  version {
   # instance_template  = google_compute_instance_template.appserver.self_link_unique
     instance_template  = each.value.instance_template
  }
  
  description= each.value.description

  all_instances_config {
    metadata = each.value.metadata
    labels   = each.value.labels
  }

  #target_pools = [each.value.target_pools]
  target_size  = each.value.target_size

  named_port {
  name = each.value.named_port.name
  port = each.value.named_port.port
  }


  auto_healing_policies {
    health_check      = each.value.auto_healing_policies.health_check
    initial_delay_sec = each.value.auto_healing_policies.initial_delay_sec
  }
}
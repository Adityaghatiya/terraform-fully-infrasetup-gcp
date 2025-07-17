#ref:- https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_group_manager.html

#for health check
resource "google_compute_health_check" "autohealing" {
  for_each=(for hlt_ck in var.autohealing:hlt_ck.name=hlt_ck)
  name                = each.name
  check_interval_sec  = each.check_interval_sec
  timeout_sec         =each.timeout_sec
  healthy_threshold   = each.healthy_threshold
  unhealthy_threshold = each.unhealthy_threshold # 50 seconds

  http_health_check {
    request_path = each.request_path
    port         = each.port
  }
}

#for managed instance group
resource "google_compute_instance_group_manager" "appserver" {
  for_each=(for igm in appserver:igm.name=igm)
  name = each.name

  base_instance_name = each.base_instance_name
  zone               =each.zone

  version {
   # instance_template  = google_compute_instance_template.appserver.self_link_unique
     instance_template  = each.instance_template
  }
  
  description= each.description

  all_instances_config {
    metadata = {
      metadata_key = "metadata_value"
    }
    labels = {
      label_key = "label_value"
    }
  }

  target_pools = [google_compute_target_pool.appserver.id]
  target_size  = 2

  named_port {
    name = "customhttp"
    port = 8888
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 300
  }
}
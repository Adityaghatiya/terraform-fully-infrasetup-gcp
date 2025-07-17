#ref:- https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_group_manager.html


#for health check
resource "google_compute_health_check" "autohealing" {
  for_each={for hlt_ck in var.autohealing:hlt_ck.name=>hlt_ck}
  name                =each.value.name
  check_interval_sec  = each.value.check_interval_sec
  timeout_sec         =each.value.timeout_sec
  healthy_threshold   =each.value.healthy_threshold
  unhealthy_threshold = each.value.unhealthy_threshold # 50 seconds

  http_health_check {
    request_path =  each.value.request_path
    port         =  each.value.port
  }
}

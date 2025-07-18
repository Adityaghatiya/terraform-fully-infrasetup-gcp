resource "google_compute_global_address" "staticip" {
  provider = google-beta
  for_each={for stk_ip in var.staticip : stk_ip.name=>stk_ip}
  name     = each.value.name
  description=each.value.description
  project = var.project_id 
}
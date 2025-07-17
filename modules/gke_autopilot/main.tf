resource "google_container_cluster" "autopilot_cluster" {
  
  for_each = {
    for cluster in var.autopilot_cluster : cluster.name => cluster
  }
   project  = var.project_id
  name     = each.value.name
  location = each.value.location

  enable_autopilot = true

  # Optional: Enterprise tier config
  dynamic "enterprise_config" {
    for_each = each.value.enterprise_config != null ? [each.value.enterprise_config] : []
    content {
      # 'enterprise_config' block is available only if desired_tier is specified
      desired_tier = enterprise_config.value.desired_tier
    }
  }

  deletion_protection = lookup(each.value, "deletion_protection", false)

  network    = var.network
  subnetwork = each.value.subnetwork

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = each.value.cluster_ipv4_cidr_block
    services_ipv4_cidr_block = each.value.services_ipv4_cidr_block
  }
}

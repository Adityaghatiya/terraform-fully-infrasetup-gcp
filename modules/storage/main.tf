#ref:- https://registry.terraform.io/providers/hashicorp/google/6.38.0/docs/resources/storage_bucket#nested_autoclass
resource "google_storage_bucket" "buckets" {
  for_each = { for bucket in var.buckets : bucket.name => bucket }

  name     = each.value.name
  location = each.value.location
  project  = var.project_id

  storage_class = each.value.storage_class
  force_destroy = each.value.force_destroy

  versioning {
    enabled = each.value.versioning
  }

  uniform_bucket_level_access = each.value.uniform_bucket_level_access

  labels = each.value.labels

  dynamic "lifecycle_rule" {
    for_each = each.value.lifecycle_rules != null ? each.value.lifecycle_rules : []
    content {
      action {
        type          = lifecycle_rule.value.action.type
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }
      condition {
        age                   = lookup(lifecycle_rule.value.condition, "age", null)
        created_before        = lookup(lifecycle_rule.value.condition, "created_before", null)
        with_state            = lookup(lifecycle_rule.value.condition, "with_state", null)
        num_newer_versions    = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
      }
    }
  }
}

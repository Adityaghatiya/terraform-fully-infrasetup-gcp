resource "google_logging_project_sink" "log_sink" {
  for_each   = { for sink in var.log_sink : sink.name => sink }

  name       = each.value.name
  destination = each.value.destination
  disabled   = lookup(each.value, "disabled", false)
  filter     = lookup(each.value, "filter", null)

   dynamic "exclusions" {
    for_each = each.value.exclusions != null ? each.value.exclusions : []
    content {
      name        = exclusions.value.name
      description = exclusions.value.description
      filter      = exclusions.value.filter
    }
  }
}

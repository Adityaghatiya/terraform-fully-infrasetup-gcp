# Output all health check self-links
output "health_check_self_links" {
  description = "Self-links of all autohealing health checks"
  value = {
    for name, hc in google_compute_health_check.autohealing :
    name => hc.self_link
  }
}
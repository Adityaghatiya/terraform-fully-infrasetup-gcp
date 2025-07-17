# Output all health check self-links
/*output "health_check_self_links" {
  description = "Self-links of all autohealing health checks"
  value = {
    for name, hc in google_compute_health_check.autohealing :
    name => hc.self_link
  }
}
*/
# Output all instance group manager names
output "instance_group_manager_names" {
  description = "Names of all created instance group managers"
  value = [
    for igm in google_compute_instance_group_manager.instance_group :
    igm.name
  ]
}
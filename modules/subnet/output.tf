output "subnet_names" {
  description = "List of created subnet names"
  value       = [for subnet in google_compute_subnetwork.subnets : subnet.name]
}

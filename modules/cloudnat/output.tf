output "cloud_nat_names" {
  value = [for nat in google_compute_router_nat.nat : nat.name]
}

output "zone_names" {
  value = [for z in google_dns_managed_zone.zones : z.name]
}

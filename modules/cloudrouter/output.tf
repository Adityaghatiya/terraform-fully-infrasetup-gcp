output "router_names" {
  value = [for r in google_compute_router.router : r.name]
}

output "router_map" {
  value = {
    for r in google_compute_router.router :
    r.name => {
      name   = r.name
      region = r.region
    }
  }
}

output "forwarding_rule_names" {
  value = [for rule in google_compute_global_forwarding_rule.fwd_rule : rule.name]
}

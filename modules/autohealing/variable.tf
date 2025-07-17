variable "autohealing" {
  description = "Health check configurations"
  type = list(object({
    name                = string
    check_interval_sec  = number
    timeout_sec         = number
    healthy_threshold   = number
    unhealthy_threshold = number
    request_path        = string
    port                = number
  }))
}

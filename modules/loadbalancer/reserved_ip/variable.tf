variable "staticip" {
  description = "List of static IP configs"
  type = list(object({
    name        = string
    description = string
  }))
}
variable "project_id" {
  description = "The ID of the project in which to provision resources"
  type        = string
}

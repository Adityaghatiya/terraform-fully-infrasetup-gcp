variable "autohealing"{
  description="It is seperate description for each health check"
  type=(list(object({
    name=string
    
  })))
}
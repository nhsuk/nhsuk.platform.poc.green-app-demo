variable "app_name" {
  type    = string
  default = "greenappdemo"
}

variable "function_app_locations" {
  type    = list(string)
  default = ["uks", "eun", "use2", "usw", "nzn", "brs"]
}

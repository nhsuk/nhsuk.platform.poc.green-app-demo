variable "app_name" {
  type    = string
  default = "greenappdemo"
}

# Regions / IDs sourced from https://api.carbonintensity.org.uk/

variable "backend_regions" {
  type = list(object({
    code   = string
    name   = string
    api_id = string
  }))
  default = [
    {
      code   = "nweng"
      name   = "North West England"
      api_id = "3"
    },
    {
      code   = "sweng"
      name   = "South West England"
      api_id = "11"
    },
    {
      code   = "swales"
      name   = "South Wales"
      api_id = "7"
    }
  ]
}

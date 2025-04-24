mock_provider "azurerm" {
  source = "./azurerm"
}

run "create_backend" {
  command = apply

  module {
    source = "../infrastructure"
  }

  variables {
    app_name = "testapp"
    backend_regions = [
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
      },
      {
        code   = "nireland"
        name   = "Northern Ireland"
        api_id = "4"
      }
    ]
  }

  assert {
    condition     = length(module.backend) == length(var.backend_regions)
    error_message = "Number of backends not as expected."
  }

  assert {
    condition = alltrue([
      for region in var.backend_regions :
      contains([for backend in module.backend : backend.region_code], region.code)
    ])
    error_message = "Backend not found for one or more regions."
  }
}

mock_provider "azurerm" {
  source = "./azurerm"
}

run "create_function_app" {
  command = apply

  module {
    source = "../infrastructure"
  }

  variables {
    app_name               = "testapp"
    function_app_locations = ["uksouth", "westus", "eastus2"]
  }

  assert {
    condition     = length(module.function_app) == length(var.function_app_locations)
    error_message = "Number of function apps not as expected."
  }

  assert {
    condition = alltrue([
      for _, function_app in module.function_app :
      contains(var.function_app_locations, function_app.resource_group.location)
    ])
    error_message = "One or more function app locations are not in the expected locations."
  }
}

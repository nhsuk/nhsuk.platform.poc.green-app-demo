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
    function_app_locations = ["uks", "eun", "use2"]
  }

  assert {
    condition     = length(module.function_app) == length(var.function_app_locations)
    error_message = "Number of function apps not as expected."
  }
}

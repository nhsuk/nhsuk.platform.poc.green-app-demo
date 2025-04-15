mock_provider "azurerm" {
}

run "setup_tests" {
  module {
    source = "./setup"
  }
}

run "create_resource_group" {
  command = apply

  module {
    source = "../infrastructure"
  }

  variables {
    app_name = run.setup_tests.app_name
  }

  assert {
    condition     = azurerm_resource_group.resource_group.name == "rg-${var.app_name}"
    error_message = "Resource group name not as expected."
  }

  assert {
    condition     = azurerm_resource_group.resource_group.location == "uksouth"
    error_message = "Resource group location not as expected."
  }
}

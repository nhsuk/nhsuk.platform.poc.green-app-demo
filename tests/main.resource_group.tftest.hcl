mock_provider "azurerm" {
  source = "./azurerm"
}

run "create_resource_group" {
  command = apply

  module {
    source = "../infrastructure"
  }

  variables {
    app_name = "testapp"
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

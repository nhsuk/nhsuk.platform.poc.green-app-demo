mock_provider "azurerm" {
}

run "setup_tests" {
  module {
    source = "./setup"
  }
}

run "create_log_analytics_workspace" {
  command = apply

  module {
    source = "../infrastructure"
  }

  variables {
    app_name = run.setup_tests.app_name
  }

  assert {
    condition     = azurerm_log_analytics_workspace.log_analytics_workspace.name == "law-${var.app_name}"
    error_message = "Log analytics workspace name not as expected."
  }

  assert {
    condition     = azurerm_log_analytics_workspace.log_analytics_workspace.location == azurerm_resource_group.resource_group.location
    error_message = "Log analytics workspace location not as expected."
  }

  assert {
    condition     = azurerm_log_analytics_workspace.log_analytics_workspace.resource_group_name == azurerm_resource_group.resource_group.name
    error_message = "Log analytics workspace resource group name not as expected."
  }

  assert {
    condition     = azurerm_log_analytics_workspace.log_analytics_workspace.sku == "PerGB2018"
    error_message = "Log analytics workspace sku not as expected."
  }

  assert {
    condition     = azurerm_log_analytics_workspace.log_analytics_workspace.retention_in_days == 30
    error_message = "Log analytics workspace retention in days not as expected."
  }
}

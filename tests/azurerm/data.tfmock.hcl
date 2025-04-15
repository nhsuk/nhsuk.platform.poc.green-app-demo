mock_resource "azurerm_log_analytics_workspace" {
  defaults = {
    id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.OperationalInsights/workspaces/workspaceName"
  }
}
mock_resource "azurerm_service_plan" {
  defaults = {
    id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Web/serverFarms/serverFarmValue"
  }
}

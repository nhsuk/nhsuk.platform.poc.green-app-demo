resource "azurerm_application_insights" "app_insights" {
  name                = "${var.app_name}-${var.region_code}-appi"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  workspace_id        = var.log_analytics_workspace_id
  application_type    = "web"
}

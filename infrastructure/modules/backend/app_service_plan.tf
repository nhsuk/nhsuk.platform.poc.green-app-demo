resource "azurerm_service_plan" "service_plan" {
  name                = "${var.app_name}-${var.region_code}-asp"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  os_type             = "Linux"
  sku_name            = "S1"
}

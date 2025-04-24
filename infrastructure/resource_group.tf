resource "azurerm_resource_group" "resource_group" {
  location = "uksouth"
  name     = "rg-${var.app_name}"
}

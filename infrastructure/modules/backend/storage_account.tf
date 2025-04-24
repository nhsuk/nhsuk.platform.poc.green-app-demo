resource "random_string" "storage_account_suffix" {
  length  = 4
  upper   = false
  special = false
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "${var.app_name}${var.region_code}sa${random_string.storage_account_suffix.result}"
  resource_group_name      = var.resource_group.name
  location                 = var.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

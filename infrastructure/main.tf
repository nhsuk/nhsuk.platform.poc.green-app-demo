terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.26.0"
    }
  }
}

provider "azurerm" {
}

resource "azurerm_resource_group" "resource_group" {
  location = "uksouth"
  name     = "rg-${var.app_name}"
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "law-${var.app_name}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

module "function_app" {
  for_each                   = toset(var.function_app_locations)
  source                     = "./modules/function_app"
  app_name                   = var.app_name
  location                   = each.value
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.3.0"
    }
  }
}

provider "azurerm" {
}

resource "azurerm_resource_group" "resource_group" {
  location = var.location
  name     = "rg-${var.app_name}"
}


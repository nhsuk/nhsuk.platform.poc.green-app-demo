module "backend" {
  for_each                   = { for region in var.backend_regions : region.code => region }
  source                     = "./modules/backend"
  app_name                   = var.app_name
  region_code                = each.value.code
  resource_group             = azurerm_resource_group.resource_group
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
}

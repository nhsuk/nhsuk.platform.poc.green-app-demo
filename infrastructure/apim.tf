resource "azurerm_api_management" "apim" {
  name                = "${var.app_name}-apim"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  publisher_name      = "admin"
  publisher_email     = "admin@example.com"
  sku_name            = "Developer_1"
}

resource "azurerm_api_management_api" "api" {
  name                = "${var.app_name}-apim-api"
  resource_group_name = azurerm_resource_group.resource_group.name
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = "${var.app_name} API"
  path                = "demo"
  protocols           = ["https"]
}

resource "azurerm_api_management_api_operation" "get_backend" {
  operation_id        = "get-backend"
  api_name            = azurerm_api_management_api.api.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.resource_group.name
  display_name        = "Get Backend"
  method              = "GET"
  url_template        = "/get-backend"
  response {
    status_code = 200
    description = "OK"
  }
}

resource "azurerm_api_management_api_operation_policy" "get_backend_policy" {
  operation_id        = azurerm_api_management_api_operation.get_backend.operation_id
  api_name            = azurerm_api_management_api.api.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_resource_group.resource_group.name
  xml_content = templatefile("${path.module}/apim_policy.xml.tmpl", {
    backend_regions = [for region in var.backend_regions : {
      code    = region.code
      name    = region.name
      api_id  = region.api_id
      backend = module.backend[region.code]
    }]
  })
}

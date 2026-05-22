
resource "azurerm_service_plan" "asp" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.service_plan_os_type
  sku_name            = var.service_plan_sku_name
  tags                = var.tags

  depends_on = [azurerm_resource_group.rg]
}


module "app_service_linux_api" {
  source = "./resources/app_service_linux"

  web_app_name               = var.web_app_api_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  azurerm_service_plan_id    = azurerm_service_plan.asp.id
  tags                       = var.tags
  web_app_app_settings       = var.web_app_api_app_settings
  virtual_network_subnet_id  = data.azurerm_subnet.app_subnet.id
  dotnet_version             = var.dotnet_version
  web_app_scm_ip_restriction = null

  depends_on = [azurerm_resource_group.rg]
}

module "app_service_linux_ui" {
  source = "./resources/app_service_linux"

  web_app_name               = var.web_app_ui_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  azurerm_service_plan_id    = azurerm_service_plan.asp.id
  tags                       = var.tags
  web_app_app_settings       = var.web_app_ui_app_settings
  virtual_network_subnet_id  = null
  dotnet_version             = null
  node_version               = var.node_version
  web_app_scm_ip_restriction = null

  depends_on = [azurerm_resource_group.rg]
}





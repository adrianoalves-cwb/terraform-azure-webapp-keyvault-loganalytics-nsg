data "azurerm_resource_group" "CEPReserved_Connected01_rg" {
  name = var.virtual_network_resource_group_name
}

# Virtual Network (Subnet)
data "azurerm_subnet" "app_subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = var.virtual_network_resource_group_name
}

# Virtual Network (VNet)
data "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.virtual_network_resource_group_name
}

# Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = var.network_security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags

  depends_on = [azurerm_resource_group.rg]
}


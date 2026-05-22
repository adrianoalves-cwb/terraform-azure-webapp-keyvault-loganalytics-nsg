
module "key_vault" {
  source = "./resources/key_vault"

  resource_group_name       = var.resource_group_name
  key_vault_name            = var.key_vault_name
  location                  = var.location
  tenant_id                 = var.tenant_id
  tags                      = var.tags
  key_vault_access_policies = var.key_vault_access_policies

  depends_on = [azurerm_resource_group.rg]
}

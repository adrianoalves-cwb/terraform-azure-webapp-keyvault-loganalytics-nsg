resource "azurerm_key_vault" "key_vault" {
  name                            = var.key_vault_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  tenant_id                       = var.tenant_id
  sku_name                        = "standard"
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false
  soft_delete_retention_days      = 90
  public_network_access_enabled   = true
  purge_protection_enabled        = false

  tags = var.tags

  network_acls {
    bypass                     = "None"
    default_action             = "Allow"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }

  dynamic "access_policy" {
    for_each = var.key_vault_access_policies

    content {
      tenant_id               = access_policy.value.tenant_id
      object_id               = access_policy.value.object_id
      key_permissions         = access_policy.value.key_permissions
      secret_permissions      = access_policy.value.secret_permissions
      certificate_permissions = access_policy.value.certificate_permissions
      storage_permissions     = access_policy.value.storage_permissions
    }
  }
}

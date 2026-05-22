variable "location" {
  description = "The location/region where the resources will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID for the Key Vault."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
}

variable "key_vault_access_policies" {
  type = list(object({
    tenant_id               = string
    object_id               = string
    key_permissions         = list(string)
    secret_permissions      = list(string)
    certificate_permissions = list(string)
    storage_permissions     = list(string)
  }))
}

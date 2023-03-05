

variable "keyvault_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}


output "terraform_vault_id" {
  value = azurerm_key_vault.terraform.id
}

variable "tenant_id" {
   type = string
}
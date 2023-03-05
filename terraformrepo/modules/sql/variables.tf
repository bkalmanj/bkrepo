variable "sqlserver" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "adminuser" {
  type = string
}

output "sql_server_id" {
  value = azurerm_sql_server.sqlname.id
}

variable "terraform_vault_id" {
  type = string
}

variable "dbname" {
  type = string

}

variable "key_vault_id" {
  type = string
}
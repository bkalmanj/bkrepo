data "azurerm_key_vault_secret" "az_sql_password" {
  name         = "az-sql-key"
  key_vault_id = var.key_vault_id
}

resource "azurerm_sql_server" "sqlname" {
  name                         = var.sqlserver
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.adminuser
  administrator_login_password = data.azurerm_key_vault_secret.az_sql_password.value

  tags = {
    environment = "dev"
  }
}

resource "azurerm_sql_firewall_rule" "rule" {
    name                = "firewallrule"
    resource_group_name = var.resource_group_name
    server_name         = azurerm_sql_server.sqlname.name
    start_ip_address    = "0.0.0.0"
    end_ip_address      = "0.0.0.0"
}

resource "azurerm_sql_database" "db" {
  name = var.dbname
  resource_group_name = var.resource_group_name
  location = var.location
  server_name = azurerm_sql_server.sqlname.name
}
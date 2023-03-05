resource "azurerm_app_service_plan" "appplan" {
  name                = var.appserviceplan
  location            = var.location
  resource_group_name = var.resource_group_name
  kind = "Linux"
  reserved = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "appname" {
  name                = var.appname
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.appplan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "tfs"
  }
 
  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=tcp:azurerm_sql_server.sqlname.fully_qualified_domain_name Database=azurerm_sql_database.db.name;User ID=azurerm_sql_server.sqlname.administrator_login;azurerm_sql_server.sqlname.administrator_login_password;Trusted_Connection=False;Encrypt=True;"
    
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "example" {
  app_service_id = azurerm_app_service.appname.id
  subnet_id      = var.azurermsubnetid
}


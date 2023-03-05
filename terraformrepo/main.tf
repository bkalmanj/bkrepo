module "base" {
    source = "./modules/base"
    resource_group_name = var.resource_group_name
    location = var.location
}

module "appservice" {
  source = "./modules/appservice"
  resource_group_name = var.resource_group_name
  appname = var.appname
  location = var.location
  appserviceplan = var.appserviceplan
  azurermsubnetid = module.network.nodes_subnet_id
}

module "keyvault" {
  source = "./modules/keyvault"
  resource_group_name = var.resource_group_name
  keyvault_name = var.keyvault_name
  location = var.location
  tenant_id = var.tenant_id
}

module "sql" {
  source = "./modules/sql"
  adminuser = var.adminuser
  location = var.location
  resource_group_name = var.resource_group_name
  sqlserver = var.sqlserver
  terraform_vault_id = module.keyvault.terraform_vault_id
  dbname = var.dbname
  key_vault_id = module.keyvault.terraform_vault_id
}

module "network" {
  source = "./modules/network"
  resource_group_name = var.resource_group_name
  location = var.location
  network_number = var.network_number
  subnet_name = var.subnet_name
  virtual_network_name = var.virtual_network_name
  backendlb = var.backendlb
  pubip = var.pubip
  frontip = var.frontip
}

module "vm" {
  source = "./modules/vm"
  webapp_test = module.appservice.webapp_url
  nic = module.network.azurerm_network_interface.nic.*.id
}
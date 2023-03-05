resource "azurerm_virtual_network" "vnet" {
  name = var.virtual_network_name
  location = var.location
  resource_group_name = var.resource_group_name
  address_space = ["10.${var.network_number}.0.0/16"]
}

resource "azurerm_subnet" "nodes" {
  name                                           = var.subnet_name
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = var.virtual_network_name
  address_prefixes                               = ["10.${var.network_number}.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
  count = 2
  name = "webnic${count.index}"
  location = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name = var.nicip
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_public_ip" "ip" {
  name = var.pubip
  location = var.location
  resource_group_name = var.resource_group_name
  allocation_method = "static"
}
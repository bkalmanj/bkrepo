

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "network_number" {
  type = number
}

output "nodes_subnet_id" {
  value = azurerm_subnet.nodes.id
}


variable "frontip" {
  type = string
}

variable "pubip" {
  type = string
}

variable "backendlb" {
  type = string
}

output "nic" {
  value = [ azurerm_network_interface.nic.id ]
}


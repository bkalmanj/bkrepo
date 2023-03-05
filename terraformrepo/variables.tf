variable "resource_group_name" {
  type = string
  default = "testrg"
}

variable "location" {
  type = string
  default = "East US"
}

variable "appserviceplan" {
  type = string
  default = "appserviceplan"
}

variable "appname" {
  type = string
  default = "testappthebest"
}

variable "sqlserver" {
  type = string
  default = "testsqlserver"
}

variable "adminuser" {
  type = string
  default = "testadmin"
}

variable "keyvault_name" {
  type = string
  default = "testkv"
}

variable "tenant_id" {
  type = string
  default = "9e0376ad-4c3f-4f9d-9e24-ec4c0eb0904d"
}

variable "dbname" {
  type = string
  default = "sqldbname"
}

variable "backendlb" {
  type = string
  default = "backendlb"
}
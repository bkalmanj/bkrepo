terraform {
  backend "azurerm" {
    subscription_id = "b5a5d863-e8d1-4068-ad0f-81ef984c6125"
    resource_group_name = "TestFirstRG"
    storage_account_name = "testfirstterrform"
    container_name = "state"
    key = "terraformapp.tfstate"
  }
}
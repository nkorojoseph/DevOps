provider "azurerm" {
  features {
    
  }
}

resource "azurerm_resource_group" "testrg" {
  name = "testResourceGroup"
  location = "westus"
}
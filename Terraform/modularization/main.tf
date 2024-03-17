# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {
  }
}

module "state-str-blob" {
  source = "./Modules/Services/StorageServices"
  resource-grp-name = "CloudNativeAzure-group"
  storage-account-name = "nkorojosephd1prod"
  azure-dc = "westus"
  storage-account-tier = "Standard"
  storage-replication-type = "LRS"
  storage-container-name = "cloud-native-devs"
  storage-container-access = "private"
  blob-name = "cloud-native-with-azure"
}

module "CloudNativeAzure-vnet" {
  source = "./Modules/Services/Virtual_network"
  vpc-cidr = ["10.0.0.0/16"]
  vpc-name = "cna-prod"
  subnet1-cidr = "10.0.1.0/24"
  subnet2-cidr = "10.0.2.0/24"
  subnet3-cidr = "10.0.3.0/24"
  network-secgrp-name = "cloudnative-public-firewall"
  resource-grp-name = "CloudNativeAzure-group"
  azure-dc = "westus"
  env-type = "Production"
}

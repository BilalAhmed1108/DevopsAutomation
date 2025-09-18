terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.40.0"
    }
  }
  # backend "azurerm" {
  #   resource_group_name  = "rg-backend"         
  #   storage_account_name = "storagebackendforsf"                             
  #   container_name       = "container"                              
  #   key                  = "fullautomation"          
  # }terraform
}

provider "azurerm" {
  features {}

}
# module for resource group
module "azurerm_resource_group" {
  source      = "../../Child/azurerm_resource_group"
  rg_variable = var.dev_rg
}

# module for storage account
module "azurerm_storage_account" {
  source       = "../../Child/azurerm_storage_account"
  depends_on   = [module.azurerm_resource_group]
  stg_variable = var.dev_stg
}

# module for virtual network
module "azurerm_virtual_network" {
  depends_on    = [module.azurerm_resource_group]
  source        = "../../Child/azurerm_virtual_network"
  vnet_variable = var.dev_vnet
}

# module for subnet
module "azurerm_subnet" {
  source     = "../../Child/azurerm_subnet"
  depends_on = [module.azurerm_virtual_network]
  subnet     = var.dev_subnet
}



# # module for bastion subnet
module "azurerm_bastionsubnet" {
  source     = "../../Child/azurerm_subnet"
  depends_on = [module.azurerm_virtual_network]
  subnet     = var.dev_bastionsubnet
}

#  module for public ip
module "azurerm_public_ip" {
  source     = "../../Child/azurerm_public_ip"
  depends_on = [module.azurerm_virtual_network]
  pip        = var.dev_pip
}

# module for network interface card front
module "azurerm_network_interface_card_front" {
  depends_on = [module.azurerm_subnet, module.azurerm_public_ip]
  source     = "../../Child/azurerm_network_interface_card"
  nic        = var.dev_frontnic
  subnet     = var.dev_data_subnet
}

# module for network interface card back
module "azurerm_network_interface_card_back" {
  depends_on = [module.azurerm_subnet, module.azurerm_public_ip]
  source     = "../../Child/azurerm_network_interface_card"
  nic        = var.dev_backnic
  subnet     = var.dev_data_subnet
}

# module for bastion
module "azurerm_bastion" {
  source      = "../../Child/azurerm_bastion"
  depends_on  = [module.azurerm_public_ip, module.azurerm_bastionsubnet]
  pip         = var.dev_bastionhost_data_pip
  subnet      = var.dev_data_bastionsubnet
  bastionhost = var.dev_bastionhost

}

# module for keyvault
module "azurerm_keyvault" {
  depends_on = [module.azurerm_resource_group]
  source     = "../../Child/azurerm_keyvault"
  keyvault   = var.dev_keyvault
}

# module for keyvault secret
module "azurerm_keyvault_secret" {
  source         = "../../Child/azurerm_keyvault_secret"
  depends_on     = [module.azurerm_keyvault]
  keyvaultsecret = var.dev_keyvaultsecret
  keyvaultid     = var.dev_keyvaultid
}

# module for virtual machine front
module "azurerm_virtual_machine_front" {
  source         = "../../Child/azurerm_virtual_machine"
  depends_on     = [module.azurerm_keyvault_secret, module.azurerm_subnet, module.azurerm_network_interface_card_front]
  vm             = var.dev_frontvm
  keyvaultid     = var.dev_keyvaultid
  keyvaultsecret = var.dev_keyvaultsecret
  nicdata        = var.dev_frontnic
}

# module for virtual machine back
module "azurerm_virtual_machine_back" {
  source         = "../../Child/azurerm_virtual_machine"
  depends_on     = [module.azurerm_keyvault_secret, module.azurerm_subnet, module.azurerm_network_interface_card_back]
  vm             = var.dev_backvm
  keyvaultid     = var.dev_keyvaultid
  keyvaultsecret = var.dev_keyvaultsecret
  nicdata        = var.dev_backnic
}

# Module for sqlserver
module "sqlserver" {
  source         = "../../Child/azurerm_sql_server"
  depends_on     = [module.azurerm_keyvault_secret]
  mssqlserver      = var.dev_mssqlserver
  keyvaultid     = var.dev_keyvaultid
  keyvaultsecret = var.dev_keyvaultsecret
}

# Module for database
module "database" {
  source = "../../Child/azurerm_sql_database"
  depends_on = [module.sqlserver ]
  database = var.dev_database
  serverdata = var.dev_serverdata
}


# # Module for load balancer
# module "load_balancer" {
#   depends_on = [ module.azurerm_public_ip ]
#   source = "../../Child/azurerm_loadbalancer"

# }
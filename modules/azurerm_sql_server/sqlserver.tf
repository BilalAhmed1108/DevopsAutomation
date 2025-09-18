resource "azurerm_mssql_server" "sqlserver" {
  for_each = var.mssqlserver
  name                         = each.value.name
  resource_group_name          = each.value.r_g_n
  location                     = each.value.location
  version                      = each.value.version 
  administrator_login          = data.azurerm_key_vault_secret.keyvaultsecret["${each.value.name}username"].value
  administrator_login_password = data.azurerm_key_vault_secret.keyvaultsecret["${each.value.name}password"].value
}




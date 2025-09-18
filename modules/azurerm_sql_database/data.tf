# SQL Server Data block
data "azurerm_mssql_server" "SQLServer" {
    for_each = var.serverdata
  name                = each.value.name
  resource_group_name =each.value.r_g_n
}
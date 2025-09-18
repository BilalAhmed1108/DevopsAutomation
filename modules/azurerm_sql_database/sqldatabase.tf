resource "azurerm_mssql_database" "sqldatabase" {
    for_each = var.database
  name         = each.value.name
  server_id    = data.azurerm_mssql_server.SQLServer[each.key].id
}
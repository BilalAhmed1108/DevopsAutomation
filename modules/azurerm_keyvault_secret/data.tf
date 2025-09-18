
data "azurerm_key_vault" "keyvaultid" {
    for_each = var.keyvaultid
  name                = each.value.name
  resource_group_name = each.value.r_g_n
}
resource "azurerm_storage_account" "stg" {
    for_each = var.stg_variable
  name = each.value.name
  location = each.value.location
  resource_group_name = each.value.r_g_n
  account_tier = each.value.a_t
  account_replication_type = each.value.a_r_t
}
resource "azurerm_resource_group" "p2rg" {
  for_each = var.environments

  name     = each.value
  location = var.rg-location
}

resource "azurerm_service_plan" "p2asplan" {
  for_each = var.environments

  name                = "${each.value}${var.name-suffix}"
  resource_group_name = azurerm_resource_group.p2rg[each.key].name
  location            = azurerm_resource_group.p2rg[each.key].location
  sku_name            = var.as-sku
  os_type             = "Windows"
}

resource "azurerm_windows_web_app" "p2asapp" {
  for_each = var.environments

  name                = "${each.value}${var.name-suffix}"
  resource_group_name = azurerm_resource_group.p2rg[each.key].name
  location            = azurerm_resource_group.p2rg[each.key].location
  service_plan_id     = azurerm_service_plan.p2asplan[each.key].id
  https_only = true

  site_config {
    always_on = true

    application_stack {
      dotnet_version = "v8.0"
    }
  }

  app_settings = { 
    WEBSITE_RUN_FROM_PACKAGE = "1"
   }
}
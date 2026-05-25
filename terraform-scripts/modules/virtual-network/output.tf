output "appgw_subnet_id" {
  value = azurerm_subnet.appgw.id
}

output "vm_subnet_id" {
  value = azurerm_subnet.vm.id
}
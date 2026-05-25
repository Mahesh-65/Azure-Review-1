variable "resource_group_name" {}
variable "location" {}

variable "vnet_name" {}
variable "address_space" {}

variable "appgw_subnet_name" {}
variable "appgw_subnet_prefix" {}

variable "vm_subnet_name" {}
variable "vm_subnet_prefix" {}

variable "nsg_name" {}

variable "frontend_vm_name" {}
variable "api_vm_name" {}

variable "vm_size" {}
variable "admin_username" {}
variable "admin_password" {}

variable "nat_pip_name" {}
variable "nat_gateway_name" {}

variable "appgw_pip_name" {}

variable "waf_policy_name" {}

variable "app_gateway_name" {}

variable "frontend_domain" {}
variable "api_domain" {}
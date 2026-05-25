resource_group_name = "Mahesh-RG"
location            = "Central India"

vnet_name     = "Mahesh-VNet"
address_space = ["10.0.0.0/16"]

appgw_subnet_name   = "appgw-subnet"
appgw_subnet_prefix = ["10.0.1.0/24"]

vm_subnet_name   = "vm-subnet"
vm_subnet_prefix = ["10.0.2.0/24"]

nsg_name = "Mahesh-NSG"

frontend_vm_name = "frontend-vm"
api_vm_name      = "api-vm"

vm_size        = "Standard_B2s"
admin_username = "Mahesh"
admin_password = "Mahesh@050903"

nat_pip_name     = "nat-pip"
nat_gateway_name = "Mahesh-NAT"

appgw_pip_name = "appgw-pip"

waf_policy_name = "Mahesh-WAF"

app_gateway_name = "Mahesh-AppGW"

frontend_domain = "maheshrevs.online"
api_domain      = "api.maheshrevs.online"
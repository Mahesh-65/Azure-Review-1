module "resource-group" {
  source              = "./modules/resource-group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "virtual-network" {
  source = "./modules/virtual-network"

  resource_group_name = module.resource-group.resource_group_name
  location            = var.location

  vnet_name      = var.vnet_name
  address_space  = var.address_space

  appgw_subnet_name   = var.appgw_subnet_name
  appgw_subnet_prefix = var.appgw_subnet_prefix

  vm_subnet_name   = var.vm_subnet_name
  vm_subnet_prefix = var.vm_subnet_prefix
}

module "network-security-group" {
  source = "./modules/network-security-group"

  resource_group_name = module.resource-group.resource_group_name
  location            = var.location

  nsg_name = var.nsg_name

  subnet_id = module.virtual-network.vm_subnet_id
}

module "app1-vm" {
  source = "./modules/virtual-machine"

  resource_group_name = module.resource-group.resource_group_name
  location            = var.location

  vm_name = var.frontend_vm_name
  vm_size = var.vm_size

  admin_username = var.admin_username
  admin_password = var.admin_password

  subnet_id = module.virtual-network.vm_subnet_id
}

module "app2-vm" {
  source = "./modules/virtual-machine"

  resource_group_name = module.resource-group.resource_group_name
  location            = var.location

  vm_name = var.api_vm_name
  vm_size = var.vm_size

  admin_username = var.admin_username
  admin_password = var.admin_password

  subnet_id = module.virtual-network.vm_subnet_id
}

module "nat-gateway" {
  source = "./modules/nat-gateway"

  resource_group_name = module.resource-group.resource_group_name
  location            = var.location

  nat_pip_name     = var.nat_pip_name
  nat_gateway_name = var.nat_gateway_name

  subnet_id = module.virtual-network.vm_subnet_id
}

module "web-application-firewall" {
  source = "./modules/web-application-firewall"

  resource_group_name = module.resource-group.resource_group_name
  location            = var.location

  waf_policy_name = var.waf_policy_name
}

module "app-gateway" {
  source = "./modules/app-gateway"

  resource_group_name = module.resource-group.resource_group_name
  location            = var.location

  app_gateway_name = var.app_gateway_name
  public_ip_name   = var.appgw_pip_name

  subnet_id = module.virtual-network.appgw_subnet_id

  frontend_vm_ip = module.app1-vm.private_ip
  api_vm_ip      = module.app2-vm.private_ip

  waf_policy_id = module.web-application-firewall.waf_policy_id

  frontend_domain = var.frontend_domain
  api_domain      = var.api_domain
}
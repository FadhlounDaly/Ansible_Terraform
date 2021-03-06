terraform {
  required_version = "~> 0.15.3"
  required_providers {
    azurerm = "~> 2.25.0"
  }
}

provider "azurerm" {
  features {
  }
}

module "linux_vm" {
  source = "./modules/linux-vm"

  rgName             = "ansibledev-${var.technician_initials}"
  rgLocation         = "japaneast"
  vnetName           = "ansibledev-${var.technician_initials}"
  vnetAddressSpace   = ["10.0.0.0/24"]
  vnetSubnetName     = "default"
  vnetSubnetAddress  = "10.0.0.0/24"
  nsgName            = "ansibledev-${var.technician_initials}"
  vmNICPrivateIP     = "10.0.0.5"
  vmPublicIPDNS      = "ansibledev-${var.technician_initials}"
  vmName             = "ansibledev-${var.technician_initials}"
  vmSize             = "Standard_B2s"
  vmAdminName        = "ansibleadmin" #If this is changed ensure you update "./scripts/ubuntu-setup-ansible.sh" with the new username
  vmShutdownTime     = "1900"
  vmShutdownTimeZone = "Tokyo Standard Time"
  vmSrcImageReference = {
    "publisher" = "Canonical"
    "offer"     = "UbuntuServer"
    "sku"       = "18.04-LTS"
    "version"   = "latest"
  }
  nsgRule1 = {
    "name"                       = "SSH_allow"
    "description"                = "Allow inbound SSH "
    "priority"                   = 100
    "direction"                  = "Inbound"
    "access"                     = "Allow"
    "protocol"                   = "Tcp"
    "source_port_range"          = "*"
    "destination_port_range"     = "22"
    "source_address_prefix"      = "*"
    "destination_address_prefix" = "10.0.0.5"
  }
}

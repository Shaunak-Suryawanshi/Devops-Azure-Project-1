variable "resource_group_name" {
  description = "Azure Resource Group name"
  type        = string
  default     = "rg-devops-azure-project"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "Central India"
}

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
  default     = "vnet-devops-project"
}

variable "vnet_address_space" {
  description = "VNet CIDR block"
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "subnet-app"
}

variable "subnet_prefixes" {
  description = "Subnet CIDR block"
  type        = list(string)
  default     = ["10.10.1.0/24"]
}

variable "public_ip_name" {
  description = "Public IP resource name"
  type        = string
  default     = "pip-devops-project"
}

variable "nsg_name" {
  description = "Network Security Group name"
  type        = string
  default     = "nsg-devops-project"
}

variable "nic_name" {
  description = "Network Interface name"
  type        = string
  default     = "nic-devops-project"
}

variable "vm_name" {
  description = "Virtual Machine name"
  type        = string
  default     = "vm-devops-project"
}

variable "vm_size" {
  description = "VM size (cost-sensitive)"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for VM"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key content"
  type        = string
}

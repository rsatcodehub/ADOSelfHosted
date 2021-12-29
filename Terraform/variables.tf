variable "rg_name" {
  #type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "location of the resource group"

}

variable "vnet_name" {
  type        = string
  description = "location of the resource group"

}

variable "kv_name" {
  type        = string
  description = "location of the resource group"

}

variable "vnet_ip_address" {
  
  description = "vnet cidr block"
}

variable "subnet_name_ado_agent" {
  type        = string
  description = "name"
}

variable "ado_agent_subnet" {
  
  description = "name"
}



variable "vm_name" {
  type        = string
  description = "name"
}



variable "vm_private_ip_address" {
  
  description = "name"
}


variable "vm_pip_name" {
  type        = string
  description = "name"
}

variable "vm_username" {
  type        = string
  description = "name"
}


variable "vm_osdisk_name" {
  type        = string
  description = "name"
}

variable "nsg_name" {
  type        = string
  description = "name"
}

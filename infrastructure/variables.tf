variable "resource_group_name" {
  type        = string
  default     = "bistec-aks-resource-group"
  description = "resource group name"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "resource region"
}

variable "storage_account_name" {
  type        = string
  description = "storage acc. name"
}

variable "aks_cluster_name" {
  type        = string
  default     = "bistec-aks-assignment"
  description = "aks cluster name"
}

variable "dns_prefix" {
  type        = string
  default     = "bistecakscluster"
  description = "dns prefix"
}

variable "node_count" {
  type        = number
  default     = 1
  description = "no. of nodes in node pool"
}

variable "vm_size" {
  type        = string
  default     = "Standard_D2s_v3"
  description = "vm size"
}

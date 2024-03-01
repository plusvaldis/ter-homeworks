###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "public_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMKnEk0+gjzck299PyMX6lmIAnLhr5HCVWM376TQbh/u user@pc"
  description = "ssh-keygen -t ed25519"
}

variable "vms_resources" {
  type=map(object({
      name = string
      cores = number
      memory = number
      core_fraction = number
      platform_version = string
      preemptible = bool
      interface_nat = bool
  }))
  default = {
    "vm_count" = {
      name = "netology-develop-platform-web"
      cores = 2
      memory = 1
      core_fraction = 20
      platform_version = "standard-v3"
      preemptible = true
      interface_nat = true
    }
    "vm_storage" = {
      name = "storage"
      cores = 2
      memory = 1
      core_fraction = 20
      platform_version = "standard-v3"
      preemptible = true
      interface_nat = true
    }
  }
}

variable "image" {
  type = string
  default = "ubuntu-2004-lts"
  description = "image"
}

variable "interface_nat" {
  type = bool
  default = true
}
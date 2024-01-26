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
  description = "VPC network & subnet name"
}


###ssh vars

#variable "vms_ssh_public_root_key" {
  #type        = string
  #default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMKnEk0+gjzck299PyMX6lmIAnLhr5HCVWM376TQbh/u user@pc"
  #description = "ssh-keygen -t ed25519"
#}
####yandex_compute_image####
variable "image" {
  type = string
  default = "ubuntu-2004-lts"
}
#####yandex_compute_instance####
#variable "vm_web_name" {
  #type = string
  #default = "netology-develop-platform-web"
#}
#variable "vm_web_platform_version" {
  #type = string
  #default = "standard-v3"
#}
#variable "vm_web_resources_core" {
  #type = number
  #default = 2
#}
#variable "vm_web_resources_memory" {
  #type = number
  #default = 1
#}
#variable "vm_web_resources_core_fraction" {
#  type = number
#  default = 20
#}
#variable "vm_web_preemptible" {
#  type = bool
#  default = true
#}
#variable "vm_web_interface_nat" {
#  type = bool
#  default = true
#}
#variable "vm_web_serial_port" {
#  type = number
#  default = 1
#}
variable "name" {
  type=string
  default="netology-develop"
}
variable "web" {
  type=string
  default="platform-web"
}
variable "db" {
  type=string
  default="platform-db"
}
variable "vms_resources" {
  type=map(object({
      cores = number
      memory = number
      core_fraction = number
      platform_version = string
      preemptible = bool
      interface_nat = bool
  }))
  default = {
    "vm_web" = {
      cores = 2
      memory = 1
      core_fraction = 20
      platform_version = "standard-v3"
      preemptible = true
      interface_nat = true
    }
    "vm_db" = {
      cores = 2
      memory = 1
      core_fraction = 20
      platform_version = "standard-v3"
      preemptible = true
      interface_nat = true
    }
  }
}
variable "ssh_root" {
  type = map(object({
    serial-port = number
    ssh-keys = string
  }))
  default = {
    "ssh" = {
      serial-port = 1
      ssh-keys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMKnEk0+gjzck299PyMX6lmIAnLhr5HCVWM376TQbh/u user@pc"
    }
  }
}

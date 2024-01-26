###cloud vars
variable "vm_db_default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "vm_db_default_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_db_vpc_name" {
  type        = string
  default     = "develop-zone-b"
  description = "VPC network & subnet name"
}


###ssh vars

#variable "vms_ssh_public_root_key_vm_db" {
#  type        = string
#  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMKnEk0+gjzck299PyMX6lmIAnLhr5HCVWM376TQbh/u user@pc"
#  description = "ssh-keygen -t ed25519"
#}
#####yandex_compute_image####
variable "vm_db_image" {
  type = string
  default = "ubuntu-2004-lts"
}
#####yandex_compute_instance####
#variable "vm_db_name" {
#  type = string
#  default = "netology-develop-platform-db"
#}
#variable "vm_db_platform_version" {
#  type = string
#  default = "standard-v3"
#}
#variable "vm_db_resources_core" {
#  type = number
#  default = 2
#}
#variable "vm_db_resources_memory" {
#  type = number
#  default = 1
#}
#variable "vm_db_resources_core_fraction" {
#  type = number
#  default = 20
#}
#variable "vm_db_preemptible" {
#  type = bool
#  default = true
#}
#variable "vm_db_interface_nat" {
#  type = bool
#  default = true
#}
#variable "vm_db_serial_port" {
#  type = number
#  default = 1
#}

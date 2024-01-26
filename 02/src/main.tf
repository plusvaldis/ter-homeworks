resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
  route_table_id = yandex_vpc_route_table.rt.id
}
resource "yandex_vpc_subnet" "develop-zone-b" {
  name           = var.vm_db_vpc_name
  zone           = var.vm_db_default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_db_default_cidr
  route_table_id = yandex_vpc_route_table.rt.id
}
resource "yandex_vpc_gateway" "nat_gateway" {
  name = "test-gateway"
  shared_egress_gateway {}
}
resource "yandex_vpc_route_table" "rt" {
  network_id     = yandex_vpc_network.develop.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

data "yandex_compute_image" "ubuntu" {
  family = var.image
}
resource "yandex_compute_instance" "platform" {
  name        = local.name_vm_web
  platform_id = var.vms_resources.vm_web.platform_version
  resources {
    cores         = var.vms_resources.vm_web.cores
    memory        = var.vms_resources.vm_web.memory
    core_fraction = var.vms_resources.vm_web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vms_resources.vm_web.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vms_resources.vm_web.interface_nat
  }

  metadata = {
    serial-port-enable = var.ssh_root.ssh.serial-port
    ssh-keys           = "ubuntu:${var.ssh_root.ssh.ssh-keys}"
  }
}

resource "yandex_compute_instance" "vm_db" {
  name        = local.name_vm_db
  platform_id = var.vms_resources.vm_db.platform_version
  resources {
    cores         = var.vms_resources.vm_db.cores
    memory        = var.vms_resources.vm_db.memory
    core_fraction = var.vms_resources.vm_db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vms_resources.vm_db.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-zone-b.id
    nat       = var.vms_resources.vm_db.interface_nat
  }

  metadata = {
    serial-port-enable = var.ssh_root.ssh.serial-port
    ssh-keys           = "ubuntu:${var.ssh_root.ssh.ssh-keys}"
  }
}

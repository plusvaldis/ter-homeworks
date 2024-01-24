resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}
resource "yandex_vpc_subnet" "develop-zone-b" {
  name           = var.vm_db_vpc_name
  zone           = var.vm_db_default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_db_default_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}
resource "yandex_compute_instance" "platform" {
  name        = var.vm_web_name
  platform_id = var.vm_web_platform_version
  resources {
    cores         = var.vm_web_resources_core
    memory        = var.vm_web_resources_memory
    core_fraction = var.vm_web_resources_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_interface_nat
  }

  metadata = {
    serial-port-enable = var.vm_web_serial_port
    ssh-keys           = "ubuntu:${var.vms_ssh_public_root_key}"
  }
}

resource "yandex_compute_instance" "vm_db" {
  name        = var.vm_db_name
  platform_id = var.vm_db_platform_version
  resources {
    cores         = var.vm_db_resources_core
    memory        = var.vm_db_resources_memory
    core_fraction = var.vm_db_resources_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-zone-b.id
    nat       = var.vm_db_interface_nat
  }

  metadata = {
    serial-port-enable = var.vm_db_serial_port
    ssh-keys           = "ubuntu:${var.vms_ssh_public_root_key_vm_db}"
  }
}

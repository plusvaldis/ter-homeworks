data "yandex_compute_image" "ubuntu-2004-lts" {
  family = var.image
}

#создаем 2 идентичные ВМ
resource "yandex_compute_instance" "example" {
  depends_on = [ yandex_compute_instance.db ]
  name        = "${var.vms_resources.vm_count.name}-${count.index + 1}"
  platform_id = var.vms_resources.vm_count.platform_version

  count = 2

  resources {
    cores         = var.vms_resources.vm_count.cores
    memory        = var.vms_resources.vm_count.memory
    core_fraction = var.vms_resources.vm_count.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
    }
  }

  metadata = local.ssh_metadata

  scheduling_policy {
    preemptible = var.vms_resources.vm_count.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vms_resources.vm_count.interface_nat
    security_group_ids = [ 
      yandex_vpc_security_group.example.id
      ]
  }
  allow_stopping_for_update = true
}
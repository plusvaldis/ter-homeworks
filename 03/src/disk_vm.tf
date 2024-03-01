resource "yandex_compute_disk" "storage_create" {
  count   = 3
  name  = "disk-${count.index + 1}"
  size  = 1
}


resource "yandex_compute_instance" "storage" {
  name = var.vms_resources.vm_storage.name
  resources {
    cores = var.vms_resources.vm_storage.cores
    memory = var.vms_resources.vm_storage.memory
    core_fraction = var.vms_resources.vm_storage.core_fraction
  }

  boot_disk {
    initialize_params {
    image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
        }
  }

  dynamic "secondary_disk" {
   for_each = { for stor in yandex_compute_disk.storage_create[*]: stor.name=> stor }
   content {
     disk_id = secondary_disk.value.id
   }
  }
  network_interface {
     subnet_id = yandex_vpc_subnet.develop.id
     nat     = var.vms_resources.vm_storage.interface_nat
  }

  metadata = local.ssh_metadata
}

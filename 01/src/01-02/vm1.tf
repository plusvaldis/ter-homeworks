resource "yandex_compute_instance" "vm1" {
  name  = "vm1"
  zone  = yandex_vpc_subnet.mysubnet-a.zone
  resources {
    cores         = 2
    memory        = 4
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = "fd8vljd295nqdaoogf3g"
      size     = 50
    }
  }
  metadata = {
    user-data = "${file("cloud-init.yaml")}"
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = "${yandex_vpc_subnet.mysubnet-a.id}"
    nat = true
  }
}
output "private_ip_connect_ssh_vm1" {
    value = yandex_compute_instance.vm1.network_interface[0].nat_ip_address
}

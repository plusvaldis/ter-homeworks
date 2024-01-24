output "vm" {
    value = [
    for i in yandex_compute_instance : {
      name           = yandex_compute_instance[i].name
      external_ip           = yandex_compute_instance[i].network_interface[0].nat_ip_address
      fqdn = yandex_compute_instance[i].fqdn
    }
  ]
}
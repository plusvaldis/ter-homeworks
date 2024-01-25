output "output_vm" {
    value = [
        {
            vm_web = ["name=${yandex_compute_instance.platform.name}",
            "external_ip=${yandex_compute_instance.platform.network_interface[0].nat_ip_address}",
            "fqdn=${yandex_compute_instance.platform.fqdn}"]
        },
        {
            vm_db = ["name=${yandex_compute_instance.vm_db.name}",
            "external_ip=${yandex_compute_instance.vm_db.network_interface[0].nat_ip_address}",
            "fqdn=${yandex_compute_instance.vm_db.fqdn}"]
        }
    ]
}

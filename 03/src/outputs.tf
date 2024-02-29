output "instances" {
  description = "Information about the instances"
  value = {
    web = [
      for instance in yandex_compute_instance.example : {
        name = instance.name
        id   = instance.id
        fqdn = instance.fqdn
      }
    ],
    db = {
      for vm in local.vms_bav : vm["vm_name"] => {
        name  = yandex_compute_instance.db[vm["vm_name"]]["name"]
        fqdn  = yandex_compute_instance.db[vm["vm_name"]]["fqdn"]
        id    = yandex_compute_instance.db[vm["vm_name"]]["id"]
      }
    },
    storage = {
      name = yandex_compute_instance.storage[*].name
      id   = yandex_compute_instance.storage[*].id
      fqdn = yandex_compute_instance.storage[*].fqdn
    }
  }
}

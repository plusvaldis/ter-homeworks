locals{
    ssh_metadata = {
      serial-port-enable = 1
      ssh-keys  = "ubuntu:${file("~/.ssh/id_ed25519.pub")} " 
    }
    vms_bav = [
        {
        vm_name = "main"
        cpu     = 4
        ram     = 4
        frac    = 20
        disk    = 10
        nat     = "true"
        platform = "standard-v1"
        },
        {
        vm_name = "replica"
        cpu     = 2
        ram     = 2
        frac    = 5
        disk    = 20
        nat     = "true"
        platform = "standard-v1"
        }
  ]
}
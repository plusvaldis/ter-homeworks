resource "yandex_vpc_network" "network-main" {
  name = "homework"
}

resource "yandex_vpc_subnet" "mysubnet-a" {
  v4_cidr_blocks = ["10.5.0.0/16"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-main.id
}

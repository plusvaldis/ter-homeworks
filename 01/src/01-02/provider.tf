terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = "y0_AgAAAAAhB-nuAATuwQAAAADWzeBaNd7_A4_-TmKihCLfBGoK7yPOn6U"
  cloud_id  = "b1gearik05mgp9nh41pt"
  folder_id = "b1gqnsno2p3pm085m9d6"
  zone      = "ru-central1-a"
}

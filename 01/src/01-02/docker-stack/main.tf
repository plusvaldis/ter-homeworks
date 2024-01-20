terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
  required_version = ">=0.13" /*Многострочный комментарий.
 Требуемая версия terraform */
}
#provider "docker" {}
provider "docker" {
  host     = "ssh://cherepanov@51.250.71.46"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

#однострочный комментарий

resource "random_password" "root_password" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "user_password" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}


resource "docker_image" "mysql"{
  name         = "mysql:8"
  keep_locally = true
  force_remove = true
}

resource "docker_container" "mysql" {
  image = docker_image.mysql.image_id
  name  = "BD_mysql"
  ports {
    internal = 3306
    external = 3306
    ip = "127.0.0.1"    
  }
  env = ["MYSQL_ROOT_PASSWORD=${random_password.root_password.result}", "MYSQL_DATABASE=wordpress", "MYSQL_USER=wordpress", "MYSQL_PASSWORD=${random_password.user_password.result}", "MYSQL_ROOT_HOST=%"]
}

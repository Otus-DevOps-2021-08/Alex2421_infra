terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}
provider "yandex" {
  token     = "AQAAAABYZt-jAATuwdBzPvdq5UNKl-seDYXPy5o"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

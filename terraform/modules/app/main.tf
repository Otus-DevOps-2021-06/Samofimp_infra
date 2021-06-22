resource "yandex_compute_instance" "app" {
  name        = "reddit-app"
  platform_id = "standard-v2"

  labels = {
      tags = "reddit-app"
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.disk_app.image_id
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
  
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}

data "yandex_compute_image" "disk_app" {
  name = var.app_disk_image
}

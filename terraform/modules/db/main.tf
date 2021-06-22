resource "yandex_compute_instance" "db" {
  name = "reddit-db"
  platform_id = "standard-v2"
  
  labels = {
    tags = "reddit-db"
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.disk_db.image_id
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }

  metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}

data "yandex_compute_image" "disk_db" {
  name = var.db_disk_image
}


resource "yandex_lb_target_group" "lb-reddit-app-target-group" {
  name      = "reddit-app-target-group"
  region_id = var.region_id

  target {
    subnet_id = var.subnet_id
    address   = yandex_compute_instance.app.network_interface.0.ip_address
  }
}

resource "yandex_lb_network_load_balancer" "reddit-app-load-balancer" {
  name = "reddit-app-load-balancer"
  type = "external"


  listener {
    name        = "lb-listener"
    port        = 8080
    target_port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.lb-reddit-app-target-group.id


    healthcheck {
      name = "reddit-app-healthcheck"
      http_options {
        port = 9292
      }
      interval            = 5
      timeout             = 2
      unhealthy_threshold = 5
      healthy_threshold   = 5
    }
  }
}

job "nginx-app" {
  datacenters = ["yourdatacenter-name"]
  type        = "service"

  group "web" {
    count = 1

    network {
      port "http" {
        to = 81
      }
    }

    task "nginx" {
      driver = "docker"

      config {
        image = "yourdockerhubusername/nginx-app:latest"
      }

      resources {
        cpu    = 50
        memory = 50
      }

      service {
        name = "nginx-app"
        port = "http"

        check {
          type     = "http"
          path     = "/health"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}

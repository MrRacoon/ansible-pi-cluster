job "simpleApp" {
  region = "global"
  datacenters = ["main"]
  type = "service"

  update {
    stagger = "30s"
    max_parallel = 2
  }

  group "webs" {
    count = 5
    task "frontend" {
      driver = "docker"
      config {
        image = "yeasy/simple-web"
      }
      service {
        port = "http"
        check {
          type     = "http"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
        }
      }

      resources {
        cpu    = 500 # MHz
        memory = 128 # MB

        network {
          mbits = 100
          port "http" {}
          port "https" {
            static = 443
          }
        }
      }
    }
  }
}

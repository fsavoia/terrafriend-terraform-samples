# main.tf

provider "docker" {
  host = "unix:///Users/fsavoia/.docker/run/docker.sock"
}

terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

# resource "docker_volume" "data" {
#   name = "my-data-volume"
# }

# resource "docker_network" "app" {
#   name   = "my-app-network"
#   driver = "bridge"
# }

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# resource "docker_image" "python" {
#   name         = "python:alpine"
#   keep_locally = false
# }


resource "docker_container" "nginx_container" {
  name  = "nginx-container"
  image = docker_image.nginx.name # Reference the "name" attribute

  ports {
    internal = 80
    external = 8080
  }

  # volumes {
  #   container_path = "/usr/share/nginx/html"
  #   host_path      = "/var/lib/docker/volumes/my-data-volume/_data"
  #   read_only      = true
  # }

  # networks_advanced {
  #   name         = docker_network.app.name
  #   ipv4_address = "172.16.238.10"
  # }
}

# resource "docker_container" "python_alpine" {
#   name  = "python-container"
#   image = docker_image.python.name # Reference the "name" attribute
# }


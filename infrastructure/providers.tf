terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.8.0"
    }
    uptimerobot = {
      source  = "louy/uptimerobot"
      version = "0.5.1"
    }
  }
  required_version = ">= 1.3"
}

provider "scaleway" {
  zone   = "fr-par-1"
  region = "fr-par"
}

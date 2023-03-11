terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.13.1"
    }
    uptimerobot = {
      source  = "louy/uptimerobot"
      version = "0.5.1"
    }
    ovh = {
      source  = "ovh/ovh"
      version = "0.25.0"
    }
  }
  required_version = ">= 1.3"
}

provider "scaleway" {
  zone   = "fr-par-1"
  region = "fr-par"
}

provider "ovh" {
  endpoint = "ovh-eu"
}

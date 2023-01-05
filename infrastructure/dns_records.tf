
# OVH records for louisparet.ovh domain
data "ovh_domain_zone" "louisparet" {
  name = "louisparet.ovh"
}

locals {
  louisparet_domain_names = toset([
    "prometheus",
    "phpmyadmin",
    "grafana",
    "portainer"
  ])
}

resource "ovh_domain_zone_record" "louisparet" {
  for_each = local.louisparet_domain_names

  zone      = data.ovh_domain_zone.louisparet.name
  subdomain = each.key
  fieldtype = "A"
  ttl       = "60"
  target    = "163.172.179.145"
}

# OVH records for lesgourmetsnomades.fr domain
data "ovh_domain_zone" "lesgourmetsnomades" {
  name = "lesgourmetsnomades.fr"
}

locals {
  lesgourmetsnomades_domain_names = toset([
    "",
    "www"
  ])
}

resource "ovh_domain_zone_record" "A-lesgourmetsnomades" {
  for_each = local.lesgourmetsnomades_domain_names

  zone      = data.ovh_domain_zone.lesgourmetsnomades.name
  subdomain = each.key
  fieldtype = "A"
  ttl       = "60"
  target    = "163.172.179.145"
}

resource "ovh_domain_zone_record" "A-www-lesgourmetsnomades" {
  zone      = data.ovh_domain_zone.lesgourmetsnomades.name
  subdomain = "www"
  fieldtype = "A"
  ttl       = "60"
  target    = "163.172.179.145"
}

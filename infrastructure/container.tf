

resource "scaleway_instance_server" "wordpress_server" {
  type  = "DEV1-S"
  name  = "wordpress_server"
  image = "ubuntu_jammy"

  ip_id = data.scaleway_instance_ip.ip.id

  root_volume {
    volume_type = "b_ssd"
    size_in_gb = 20
  }

  tags = ["lesgourmetsnomades", "snazzy-events", "rominaromay"]
}

data "scaleway_instance_ip" "ip" {
  address = "163.172.179.145"
}

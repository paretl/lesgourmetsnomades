# Get mail alert contact
data "uptimerobot_alert_contact" "mail_alert_contact" {
  friendly_name = "louis.paret@gmail.com"
}

# Create a monitor
resource "uptimerobot_monitor" "status" {
  friendly_name = "Les Gourmets Nomades"
  type          = "http"
  url           = "http://lesgourmetsnomades.fr"

  alert_contact {
    id = data.uptimerobot_alert_contact.mail_alert_contact.id
  }
}

# provisioned_by = dns-zones-observatudo
resource "google_dns_record_set" "domain_verification" {
  name         = "observatudo.com.br."
  type         = "TXT"
  ttl          = 300
  managed_zone = google_dns_managed_zone.observatudo.name
  project      = var.project_id
  rrdatas      = ["\"google-site-verification=GDnV-hzuk6ywxz1URyEFdo8_Aess8gUxwrd7dwTpHuU\""]
}

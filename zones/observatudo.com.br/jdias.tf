resource "google_dns_record_set" "jdias_cname" {
  name         = "jdias.observatudo.com.br."
  type         = "CNAME"
  ttl          = 300
  managed_zone = google_dns_managed_zone.observatudo.name
  project      = var.project_id
  rrdatas      = ["jjdsnt.github.io."]
}

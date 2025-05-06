resource "google_project_iam_member" "ci_dns_admin" {
  project = var.project_id
  role    = "roles/dns.admin"
  member  = "serviceAccount:${google_service_account.ci_terraform.email}"
}

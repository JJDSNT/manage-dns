resource "google_service_account" "ci_terraform" {
  account_id   = "terraform-ci"
  display_name = "Terraform CI Service Account"
  description  = "Service account usada pelo GitHub Actions para aplicar o Terraform"
}

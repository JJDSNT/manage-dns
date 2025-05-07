resource "google_service_account" "terraform_ci" {
  account_id   = "terraform-ci"
  display_name = "Terraform CI/CD"
  description  = "Service Account usada para aplicar configurações do Terraform com permissões mínimas"
}

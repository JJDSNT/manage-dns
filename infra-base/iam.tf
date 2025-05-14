# Permissão DNS para a service account do Terraform CI
# provisioned_by = infra-base
resource "google_project_iam_member" "terraform_ci_dns" {
  project = var.project_id
  role    = "roles/dns.admin"
  member  = "serviceAccount:${google_service_account.terraform_ci.email}"
}

resource "google_project_iam_member" "terraform_ci_storage" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.terraform_ci.email}"
}

resource "google_project_iam_member" "terraform_ci_iam_viewer" {
  project = var.project_id
  role    = "roles/iam.serviceAccountViewer"
  member  = "serviceAccount:${google_service_account.terraform_ci.email}"
}

# Permissão CI/CD para a service account do Github Actions
resource "google_project_iam_member" "github_actions_iam_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.github_actions_deploy.email}"
}

resource "google_project_iam_member" "github_actions_run_admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${google_service_account.github_actions_deploy.email}"
}

resource "google_project_iam_member" "github_actions_oidc_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.github_actions_deploy.email}"
}

resource "google_project_iam_member" "github_actions_registry_reader" {
  project = var.project_id
  role    = "roles/storage.objectViewer" # ou roles/artifactregistry.reader se estiver usando Artifact Registry
  member  = "serviceAccount:${google_service_account.github_actions_deploy.email}"
}

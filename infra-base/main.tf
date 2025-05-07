terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Os recursos estão organizados em arquivos separados:
# - bucket.tf
# - service_account.tf
# - iam.tf (opcional)
# Estes serão incluídos automaticamente durante a execução.

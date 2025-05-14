# Módulo: infra-base
# Todos os recursos definidos neste diretório são rotulados com provisioned_by = "infra-base",
# quando o recurso suportar labels. O state é armazenado com prefixo 'infra-base' no GCS.

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
# - enable_apis.tf
# - iam.tf
# - service_account.tf
# - bucket.tf
# Estes serão incluídos automaticamente durante a execução.

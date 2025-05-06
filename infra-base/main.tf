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
  region  = "us-central1"
}

# Importa os recursos definidos nos arquivos separados
# (Apenas por estarem no mesmo diretório, já serão incluídos automaticamente)

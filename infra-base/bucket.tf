resource "google_storage_bucket" "terraform_state" {
  name     = "tfstate-observatudo"
  location = "us-east1"

  
  labels = {
    provisioned_by = var.state_label
  }

  force_destroy               = false
  uniform_bucket_level_access = true

  versioning {
    enabled = false
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 365
    }
  }
}

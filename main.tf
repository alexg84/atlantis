terraform {
  required_version = ">= 1.0"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

# Simple random resources for testing
resource "random_string" "app_suffix" {
  length  = 8
  special = false
  upper   = false
}

# Simple null resource for testing
resource "null_resource" "simple_test" {
  triggers = {
    app_name = var.app_name
    suffix   = random_string.app_suffix.result
  }

  provisioner "local-exec" {
    command = "echo 'Testing Atlantis with ${var.app_name}-${random_string.app_suffix.result} in ${var.environment} environment'"
  }
}

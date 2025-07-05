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

resource "random_integer" "port" {
  min = 8000
  max = 9000
}

# Simple local file for testing
resource "local_file" "test_config" {
  content = templatefile("${path.module}/templates/simple-config.tpl", {
    app_name    = var.app_name
    environment = var.environment
    port        = random_integer.port.result
    suffix      = random_string.app_suffix.result
  })
  filename = "${path.module}/generated/test-config.json"
}

# Simple null resource for testing
resource "null_resource" "simple_test" {
  triggers = {
    app_name       = var.app_name
    config_content = local_file.test_config.content
  }

  provisioner "local-exec" {
    command = "echo 'Testing Atlantis with ${var.app_name} in ${var.environment} environment'"
  }
}

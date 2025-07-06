variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "test-app"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "poc"

  validation {
    condition     = contains(["dev", "staging", "prod", "poc"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod, poc."
  }
}

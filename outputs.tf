output "app_name" {
  description = "Name of the application"
  value       = var.app_name
}

output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "random_suffix" {
  description = "Random suffix generated for this run"
  value       = random_string.app_suffix.result
}

output "app_instance_id" {
  description = "Application instance identifier"
  value       = "${var.app_name}-${random_string.app_suffix.result}"
}

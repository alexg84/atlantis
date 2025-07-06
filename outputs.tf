output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "atlantis_poc_result" {
  description = "Random string generated for Atlantis POC"
  value       = random_string.atlantis_poc.result
}

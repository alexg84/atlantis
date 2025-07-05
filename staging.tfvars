# Staging configuration for Kubernetes testing
app_name        = "staging-app"
environment     = "staging"
replicas        = 3
app_port        = 8080
container_image = "nginx:alpine"
cpu_limit       = "1000m"
memory_limit    = "1Gi"
cpu_request     = "250m"
memory_request  = "256Mi"
enable_logging  = true
max_connections = 200

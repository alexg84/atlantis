{
  "application": {
    "name": "${app_name}",
    "environment": "${environment}",
    "port": ${port},
    "version": "1.0.0",
    "logging": {
      "enabled": true,
      "level": "${environment == "dev" ? "debug" : "info"}"
    },
    "security": {
      "secret_key": "${secret_key}"
    },
    "database": {
      "type": "h2",
      "url": "jdbc:h2:mem:testdb",
      "pool_size": 10
    },
    "kubernetes": {
      "namespace": "${app_name}-${environment}",
      "service_account": "default",
      "pod_security_context": {
        "run_as_user": 1000,
        "run_as_group": 1000,
        "fs_group": 1000
      }
    }
  },
  "server": {
    "port": ${port},
    "host": "0.0.0.0",
    "max_connections": 100,
    "timeout": 30
  },
  "monitoring": {
    "health_check": "/health",
    "readiness_check": "/ready",
    "metrics_endpoint": "/metrics"
  }
}

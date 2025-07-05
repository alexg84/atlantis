app.name=${app_name}
app.environment=${environment}
app.port=${port}
app.replicas=${replicas}

# Server Configuration
server.port=${port}
server.address=0.0.0.0

# Logging Configuration
logging.level.root=INFO
logging.level.com.example=${environment == "dev" ? "DEBUG" : "INFO"}

# Database Configuration
database.type=h2
database.url=jdbc:h2:mem:testdb
database.driver=org.h2.Driver

# Cache Configuration
cache.enabled=true
cache.ttl=3600

# Metrics Configuration
metrics.enabled=true
metrics.endpoint=/metrics

# Health Check Configuration
management.health.enabled=true
management.health.endpoint=/health
management.ready.endpoint=/ready

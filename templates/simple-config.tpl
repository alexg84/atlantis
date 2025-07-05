{
  "application": {
    "name": "${app_name}",
    "environment": "${environment}",
    "port": ${port},
    "instance_id": "${app_name}-${suffix}",
    "timestamp": "${timestamp()}"
  },
  "config": {
    "debug": true,
    "test_mode": true
  }
}

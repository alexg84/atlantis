# Kubernetes Deployment Information

## Application Details
- **Name**: ${app_name}
- **Environment**: ${environment}
- **Namespace**: ${namespace}
- **Container Image**: ${container}
- **Replicas**: ${replicas}

## Service Information
- **Service Name**: ${service_name}
- **NodePort**: ${node_port}
- **Access URL**: http://$(minikube ip):${node_port}

## Useful Commands

### Check deployment status
```bash
kubectl get deployments -n ${namespace}
kubectl get pods -n ${namespace}
kubectl get services -n ${namespace}
```

### View logs
```bash
kubectl logs -f deployment/${app_name}-deployment -n ${namespace}
```

### Scale deployment
```bash
kubectl scale deployment ${app_name}-deployment --replicas=5 -n ${namespace}
```

### Access the application
```bash
# Get Minikube IP
minikube ip

# Access the application
curl http://$(minikube ip):${node_port}

# Or open in browser
minikube service ${service_name} -n ${namespace}
```

### Port forwarding (alternative access method)
```bash
kubectl port-forward service/${service_name} 8080:80 -n ${namespace}
# Then access at http://localhost:8080
```

### Clean up
```bash
kubectl delete namespace ${namespace}
```

## Monitoring

### Get pod details
```bash
kubectl describe pods -n ${namespace}
```

### Check resource usage
```bash
kubectl top pods -n ${namespace}
kubectl top nodes
```

### View events
```bash
kubectl get events -n ${namespace} --sort-by='.lastTimestamp'
```

# Minimal Terraform Configuration for Atlantis Testing

This repository contains a minimal, local-only Terraform configuration designed for testing Atlantis functionality without any cloud dependencies or complex resources.

## 🎯 Features

- **Local-only resources**: No cloud dependencies, Docker, Minikube, or Kubernetes required
- **Simple plan**: Generates a very small plan perfect for Atlantis smoke testing
- **Fast execution**: Quick to initialize, plan, and apply
- **No external services**: Everything runs locally

## 📁 What This Creates

- `random_string.app_suffix`: Generates a random 8-character suffix
- `random_integer.port`: Generates a random port between 8000-9000
- `local_file.test_config`: Creates a simple JSON config file from a template
- `null_resource.simple_test`: Runs local shell commands for testing

## 🚀 Quick Start

```bash
# Initialize Terraform
terraform init

# See the plan
terraform plan

# Apply the configuration
terraform apply

# Clean up when done
terraform destroy
```

## 🔍 Testing with Atlantis

This configuration is perfect for testing Atlantis because:

1. **Fast plans**: The plan output is small and easy to review
2. **No dependencies**: No external services or complex setup required
3. **Predictable**: Uses simple resources that always work
4. **Safe**: No risk of creating expensive cloud resources

## 📝 Files Created

- `generated/test-config.json`: A simple configuration file
- `logs/atlantis-test.log`: Test execution log

## 🛠 Configuration

You can customize the setup by modifying variables:

```bash
# Using terraform.tfvars
echo 'app_name = "my-test-app"' > terraform.tfvars
echo 'environment = "staging"' >> terraform.tfvars

# Or using command line
terraform apply -var="app_name=my-test-app" -var="environment=prod"
```

## 📋 Available Variables

- `app_name`: Name of the application (default: "test-app")
- `environment`: Environment (dev, staging, prod) (default: "dev")

## 📤 Outputs

After applying, you'll see outputs including:
- Application instance ID
- Random values generated
- Path to created config file

This minimal setup ensures Atlantis can process plans quickly and reliably for testing purposes.
# Recommended approach:
./setup.sh
terraform init
terraform apply

# Access your app:
minikube service my-test-app-service -n [namespace]
```

## 🔧 **How the Fix Works**

1. **Dependencies**: All Kubernetes resources depend on `null_resource.minikube_start`
2. **Marker File**: Creates `.minikube-ready` when setup is complete
3. **Setup Script**: Handles the initial Minikube configuration
4. **Provider Configuration**: Uses standard minikube context

## 📁 **What This Creates**

- **Kubernetes namespace** with proper labeling
- **ConfigMap** with application configuration  
- **Secret** with sensitive data (base64 encoded)
- **Deployment** with nginx container (configurable)
- **NodePort Service** for external access
- **Local files** with deployment information

## ⚙️ **Configuration Options**

```hcl
# terraform.tfvars
app_name         = "my-test-app"
environment      = "dev"  
container_image  = "nginx:latest"
replicas         = 2
app_port         = 80
```

## 🌊 **Atlantis Workflow**

1. **Initial setup**: Run `./setup.sh` once
2. **Make changes** to `.tf` or `.tfvars` files
3. **Commit and push** to trigger Atlantis autoplan  
4. **Review the plan** in your PR/MR
5. **Comment `atlantis apply`** to apply changes

## 🛠️ **Troubleshooting**

### If you still get the context error:
```bash
# Check if Minikube is running
minikube status

# If not running, start it
minikube start

# Set the context
kubectl config use-context minikube

# Try Terraform again
terraform apply
```

### If Minikube won't start:
```bash
# Check Docker Desktop is running
docker ps

# Reset Minikube if needed
minikube delete
minikube start --driver=docker
```

## 🎉 **Benefits**

- ✅ **Solves the provider context issue**
- ✅ **Real Kubernetes testing**
- ✅ **No cloud costs**
- ✅ **Perfect for Atlantis workflows**
- ✅ **Educational and practical**

The key is ensuring Minikube is running **before** Terraform tries to configure the Kubernetes provider!

#!/bin/bash

echo "🛠️  Atlantis Minikube Setup"
echo "=========================="

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Docker is running
echo "🐳 Checking Docker Desktop..."
if ! docker ps >/dev/null 2>&1; then
    echo "❌ Docker Desktop is not running!"
    echo "📝 Please start Docker Desktop first:"
    echo "   1. Open Docker Desktop application"
    echo "   2. Wait for it to start (whale icon in menu bar)"
    echo "   3. Run this script again"
    exit 1
else
    echo "✅ Docker Desktop is running"
fi

# Check if this is the first run
if [ ! -f ".minikube-ready" ]; then
    echo "🔧 First-time setup detected. Setting up Minikube..."
    
    # Check if Minikube is installed
    if ! command_exists minikube; then
        echo "📦 Installing Minikube..."
        if command_exists brew; then
            brew install minikube
        else
            echo "❌ Homebrew not found. Please install Minikube manually:"
            echo "   https://minikube.sigs.k8s.io/docs/start/"
            exit 1
        fi
    else
        echo "✅ Minikube is already installed"
    fi
    
    # Check if kubectl is installed
    if ! command_exists kubectl; then
        echo "📦 Installing kubectl..."
        if command_exists brew; then
            brew install kubectl
        else
            echo "❌ Homebrew not found. Please install kubectl manually"
            exit 1
        fi
    else
        echo "✅ kubectl is already installed"
    fi
    
    # Start Minikube
    echo "🚀 Starting Minikube..."
    if minikube start --driver=docker --memory=4096 --cpus=2; then
        echo "✅ Minikube started successfully"
    else
        echo "❌ Failed to start Minikube"
        echo "💡 Try: minikube delete && minikube start"
        exit 1
    fi
    
    # Set context
    echo "🔧 Setting kubectl context to minikube..."
    if kubectl config use-context minikube; then
        echo "✅ kubectl context set to minikube"
    else
        echo "❌ Failed to set kubectl context"
        exit 1
    fi
    
    # Wait for cluster to be ready
    echo "⏳ Waiting for cluster to be ready..."
    if kubectl wait --for=condition=Ready nodes --all --timeout=300s; then
        echo "✅ Cluster is ready"
    else
        echo "❌ Cluster failed to become ready"
        exit 1
    fi
    
    # Verify cluster
    echo "✅ Verifying cluster..."
    kubectl cluster-info
    
    # Create marker file
    echo "Creating readiness marker..."
    echo "minikube ready at $(date)" > .minikube-ready
    
    echo ""
    echo "🎉 Minikube is ready! You can now run Terraform:"
    echo "   terraform init"
    echo "   terraform plan" 
    echo "   terraform apply"
    
else
    echo "✅ Minikube setup already complete"
    echo "🔍 Current status:"
    
    # Verify Minikube is still running
    if minikube status | grep -q "Running"; then
        echo "✅ Minikube is running"
        
        # Ensure context is set
        if kubectl config use-context minikube; then
            echo "✅ kubectl context set to minikube"
        else
            echo "⚠️  Failed to set context, but continuing..."
        fi
        
        echo ""
        echo "Ready to run Terraform!"
    else
        echo "⚠️  Minikube is not running. Starting it now..."
        if minikube start; then
            kubectl config use-context minikube
            echo "✅ Minikube restarted and ready"
        else
            echo "❌ Failed to restart Minikube"
            exit 1
        fi
    fi
fi

echo ""
echo "🔍 Final verification:"
echo "Current kubectl context: $(kubectl config current-context 2>/dev/null || echo 'No context')"
echo "Cluster status:"
if kubectl cluster-info --request-timeout=5s >/dev/null 2>&1; then
    echo "✅ Cluster is accessible"
    kubectl get nodes 2>/dev/null || echo "⚠️  Could not get nodes"
else
    echo "❌ Cluster is not accessible"
    echo "💡 You may need to restart Minikube manually"
fi

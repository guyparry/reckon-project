#!/bin/bash

# Reckon Infrastructure Deployment Script
# Optimized for hobby projects with cost savings

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    # Check if Terraform is installed
    if ! command -v terraform &> /dev/null; then
        print_error "Terraform is not installed. Please install Terraform first."
        exit 1
    fi
    
    # Check if gcloud is installed
    if ! command -v gcloud &> /dev/null; then
        print_error "Google Cloud CLI is not installed. Please install gcloud first."
        exit 1
    fi
    
    # Check if user is authenticated
    if ! gcloud auth list --filter=status:ACTIVE --format="value(account)" | grep -q .; then
        print_error "Not authenticated with Google Cloud. Please run 'gcloud auth login' first."
        exit 1
    fi
    
    print_success "Prerequisites check passed!"
}

# Function to validate project ID
validate_project() {
    local project_id=$1
    
    if [[ -z "$project_id" ]]; then
        print_error "Project ID is required"
        exit 1
    fi
    
    # Check if project exists and user has access
    if ! gcloud projects describe "$project_id" &> /dev/null; then
        print_error "Project '$project_id' not found or access denied"
        exit 1
    fi
    
    print_success "Project '$project_id' is valid"
}

# Function to deploy environment
deploy_environment() {
    local project_id=$1
    
    print_status "Deploying production environment for project: $project_id"
    
    # Navigate to environment directory
    cd "environments/production"
    
    # Initialize Terraform
    print_status "Initializing Terraform..."
    terraform init
    
    # Plan deployment
    print_status "Planning deployment..."
    terraform plan -var="project_id=$project_id"
    
    # Ask for confirmation
    echo
    print_warning "This will create infrastructure that may incur costs."
    read -p "Do you want to proceed with the deployment? (y/N): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Apply deployment
        print_status "Applying deployment..."
        terraform apply -var="project_id=$project_id" -auto-approve
        
        # Show outputs
        print_success "Deployment completed successfully!"
        echo
        print_status "Infrastructure outputs:"
        terraform output
        
        # Show cost estimate
        echo
        print_warning "Estimated monthly cost for production: $20-40"
        print_status "With $300 GCP credits, this should last 6-12 months!"
        
    else
        print_warning "Deployment cancelled"
        exit 0
    fi
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [project-id]"
    echo
    echo "Examples:"
    echo "  $0 my-production-project"
    echo
    echo "This script will deploy the Reckon infrastructure for production."
    echo "Make sure to update the terraform.tfvars file with your specific configuration."
}

# Main script
main() {
    echo "🏗️  Reckon Infrastructure Deployment Script"
    echo "=============================================="
    echo
    
    # Check if correct number of arguments
    if [[ $# -ne 1 ]]; then
        print_error "Invalid number of arguments"
        show_usage
        exit 1
    fi
    
    local project_id=$1
    
    # Check prerequisites
    check_prerequisites
    
    # Validate project
    validate_project "$project_id"
    
    # Deploy environment
    deploy_environment "$project_id"
    
    print_success "Deployment script completed!"
}

# Run main function with all arguments
main "$@" 
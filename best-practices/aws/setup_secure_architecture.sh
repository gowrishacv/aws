#!/bin/bash

# This script sets up a secure AWS reference architecture using Terraform.
# Reference: https://www.hashicorp.com/blog/building-a-secure-aws-reference-architecture-with-terraform

# Ensure AWS CLI is installed and configured
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI is not installed. Please install it first."
    exit 1
fi

echo "ℹ️ Ensure your AWS CLI is configured with appropriate credentials before proceeding."
read -p "Press Enter to continue..."

# Initialize Terraform
terraform init || { echo "❌ Terraform initialization failed"; exit 1; }

# Validate Terraform configuration
terraform validate || { echo "❌ Terraform validation failed"; exit 1; }

# Plan the deployment
terraform plan -out=tfplan || { echo "❌ Terraform plan failed"; exit 1; }

# Apply the deployment
terraform apply tfplan || { echo "❌ Terraform apply failed"; exit 1; }

echo "✅ Secure AWS reference architecture deployed successfully!"

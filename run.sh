#!/bin/bash
set -e

# Function to display the menu
show_menu() {
  echo "Select an option:"
  echo "1) Terraform Apply (Provision Infrastructure)"
  echo "2) Terraform Destroy (Clean Up Infrastructure)"
  echo "3) Exit"
  read -p "Enter your choice [1-3]: " choice
}

# Directories
TERRAFORM_DIR="/Users/shravanchandraparikipandla/Documents/repo/daniil-luminor/terraform"

# Menu loop
while true; do
  show_menu
  case $choice in
    1)
      # --- Phase 1: Infra (EKS, VPC, IAM, aws_auth_roles) ---

        echo "========================"
        echo "Applying Infrastructure"
        echo "========================"
        cd "$TERRAFORM_DIR"/infra

        terraform init -input=false
        terraform plan
        terraform apply -auto-approve

        echo "Infra phase complete."

# --- Phase 2: Workloads (Kubernetes/Helm providers, helm_release, etc) ---

        echo "========================"
        echo "Applying Workloads"
        echo "========================"
        cd "$TERRAFORM_DIR"/helm

        terraform init -input=false
        terraform plan
        terraform apply -auto-approve

        echo "Helm phase complete."
      break
      ;;
    2)
      echo "You chose: Terraform Destroy"
      echo "Destroying infrastructure with Terraform..."

      # Navigate to Terraform directory
      cd "$TERRAFORM_DIR"/infra

      # Initialize Terraform (in case it hasn't been initialized)
      terraform init

      # Destroy the infrastructure
      terraform destroy -auto-approve

      echo "Terraform Destroy completed successfully!"
      break
      ;;
    3)
      echo "Exiting the script."
      exit 0
      ;;
    *)
      echo "Invalid choice, please try again."
      ;;
  esac
done


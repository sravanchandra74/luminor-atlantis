# Atlantis on AWS EKS — Automated IaC Deployment (Terraform + Helm)

## 🚀 Project Overview

This repository demonstrates a **fully automated deployment of Atlantis on AWS EKS** using Terraform and Helm, following DevOps best practices. The goal: **Zero manual AWS console steps** — everything is Infrastructure-as-Code.

Atlantis enables GitOps for Terraform, automating PR-based infrastructure changes.

---

## 🗂️ Repository Structure
```bash
.
├── infra/ # Terraform: AWS infrastructure (VPC, EKS, IAM, etc.)
│ ├── eks.tf
│ ├── iam.tf
│ ├── main.tf
│ ├── network.tf
│ ├── outputs.tf
│ ├── variables.tf
├── helm/ # Terraform: Atlantis deployment (via Helm provider)
│ ├── helm-atlantis.tf
│ ├── outputs.tf
│ ├── providers.tf
│ ├── terraform.tfvars
│ ├── variables.tf
├── run.sh # Shell script: End-to-end automation entrypoint
```

---

## 🛠️ Stack & Tools

- **Terraform**: Infrastructure provisioning (VPC, EKS, IAM, Node Groups, EBS CSI, etc.)
- **Helm via Terraform**: Atlantis deployment on EKS as a LoadBalancer Service
- **AWS EKS**: Managed Kubernetes cluster
- **AWS IAM**: Automated least-privilege permissions for EKS and EBS
- **AWS EBS CSI Add-on**: Kubernetes persistent storage via Terraform
- **GitHub**: PR-based automation via Atlantis, with webhooks integration

---

## ⚡ Quickstart (One-Click Deploy)

### Prerequisites

- AWS CLI configured (with sufficient IAM permissions)
- Terraform (>= 1.3)
- kubectl & helm (local, for troubleshooting only)
- GitHub repo for Atlantis integration (PAT and webhook secret)

### 1. Configure Variables

Edit `helm/terraform.tfvars` to set your environment-specific values:

```hcl
aws_region         = "eu-north-1"
cluster_name       = "luminor-dev-eks"
github_token       = "YOUR_GITHUB_PAT"
github_user        = "YOUR_GITHUB_USERNAME"
webhook_secret     = "YOUR_RANDOM_SECRET"
repo_whitelist     = ["github.com/<org>/<repo>"]
org_whitelist      = ["<org>"]
```

## 🚀 How to Run It

Ready to see it in action? Follow these simple steps:

### 1️⃣ Clone the Repository

First, get the code onto your machine:
```bash
git clone <repo-url> # Replace <repo-url> with repository's URL
cd luminor-atlantis
```
2️⃣ Run the Interactive Script
This script makes it easy to manage the project's lifecycle:
```bash
sh run.sh
```
You'll then see a menu with these options:

| Option | Description                                               |
| :----- | :-------------------------------------------------------- |
| `1`    | Provisions infrastructure using Terraform and deploys the app using Ansible. |
| `2`    | Destroys all infrastructure provisioned by Terraform.     |
| `3`    | Exits the interface.                                      |

---

## What’s Automated
- VPC, Subnets, Security Groups: Isolated and secure Kubernetes networking

- EKS Cluster & Node Groups: One-click, production-ready K8s control/data plane

- IAM Role Policies: EBS CSI permissions automatically assigned to Node Groups

- EBS CSI Add-on: Enabled via Terraform for persistent storage

- Atlantis via Helm: Deployed as LoadBalancer (public ELB DNS outputted)

- GitHub Webhook: Atlantis /events endpoint exposed, ready for PR automation

## Usage Workflow
- PR to your repo → Triggers GitHub webhook to Atlantis

- Atlantis comments and runs terraform plan/apply as per workflow

- All infra changes are versioned, auditable, and require no console clicking

![image](https://github.com/user-attachments/assets/2ed87862-adee-46f1-a575-e25403c981f3)

![image](https://github.com/user-attachments/assets/a860452e-3f7f-4d09-8d38-3379dbbb8c4e)

## Troubleshooting
- Atlantis not working?

- Check pod status: kubectl get pods

- See logs: kubectl logs -n default atlantis-0

- PVC stuck Pending?

- Confirm EBS CSI add-on status and IAM role attachment (auto-managed)

- UI 404/405?

- Root / is the Atlantis web UI; /events is POST-only for webhooks

## Outputs
- After deployment, Terraform outputs:

- atlantis_url — use for GitHub webhook target

## License
Apache 2.0

## Author
- Shravan Chandra Parikipandla

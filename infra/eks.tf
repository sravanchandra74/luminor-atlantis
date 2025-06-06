module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name    = var.cluster_name         # e.g. "luminor-dev-eks"
  cluster_version = "1.28"
  vpc_id          = aws_vpc.main.id
  subnet_ids      = aws_subnet.public[*].id
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  # Enable EBS CSI driver addon via module!
  cluster_addons = {
    aws-ebs-csi-driver = {
      resolve_conflicts = "OVERWRITE"
      most_recent       = true
    }
  }

  eks_managed_node_groups = {
    default = {
      desired_capacity = 1
      min_capacity     = 1
      max_capacity     = 2
      instance_types   = ["t3.medium"]
      attach_ebs_csi_policy = true
    }
    node_group_defaults = {
    name = "luminor-ng-default"
  }
  }

  aws_auth_roles = [
    {
      rolearn  = aws_iam_role.eks_admin.arn
      username = "eks-admin"
      groups   = ["system:masters"]
    },
    {
      rolearn  = aws_iam_role.eks_readonly.arn
      username = "eks-readonly"
      groups   = ["view"]
    }
  ]
}


data "aws_eks_cluster" "this" {
  name = module.eks.cluster_name
  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
  depends_on = [module.eks]
}

resource "null_resource" "wait_for_eks" {
  provisioner "local-exec" {
    command = <<-EOT
      aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name}
      for i in {1..60}; do
        READY=$(kubectl get nodes --no-headers 2>/dev/null | grep -c ' Ready')
        if [ "$READY" -ge 1 ]; then
          echo "EKS nodes are up and Ready"
          exit 0
        fi
        echo "Waiting for EKS nodes to be Ready..."
        sleep 10
      done
      echo "Timeout waiting for EKS nodes to be Ready"
      exit 1
    EOT
    interpreter = ["bash", "-c"]
  }

  depends_on = [module.eks]
}

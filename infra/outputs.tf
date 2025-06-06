#output "cluster_endpoint" {
#  value = module.eks.cluster_endpoint
#}

output "cluster_ca" {
  value = module.eks.cluster_certificate_authority_data
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "node_group_iam_role_name" {
  value = module.eks.eks_managed_node_groups["default"].iam_role_name
}

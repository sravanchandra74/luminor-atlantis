data "kubernetes_service" "atlantis" {
  metadata {
    name      = helm_release.atlantis.name
    namespace = "default"
  }
  depends_on = [helm_release.atlantis]
}

output "atlantis_url" {
  value = try(
    data.kubernetes_service.atlantis.status[0].load_balancer[0].ingress[0].hostname,
    data.kubernetes_service.atlantis.status[0].load_balancer[0].ingress[0].ip,
    "pending"
  )
}

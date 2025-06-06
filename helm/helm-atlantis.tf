resource "helm_release" "atlantis" {
  name       = "atlantis"
  chart      = "atlantis"
  repository = "https://runatlantis.github.io/helm-charts"
  namespace  = "default"

  set {
    name  = "dataStorage"
    value = "5Gi"
  }

  set {
    name  = "storageClassName"
    value = "gp2"
  }

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "service.port"
    value = "80"
  }

  set {
    name  = "environment.ATLANTIS_GH_TOKEN"
    value = var.github_token
  }

  set {
    name  = "environment.ATLANTIS_GH_USER"
    value = var.github_user
  }

  set {
    name  = "environment.ATLANTIS_GH_WEBHOOK_SECRET"
    value = var.webhook_secret
  }

  set {
    name  = "environment.ATLANTIS_REPO_WHITELIST"
    value = join(",", var.repo_whitelist)
  }

  set {
    name  = "environment.ATLANTIS_ORG_WHITELIST"
    value = join(",", var.org_whitelist)
  }
}

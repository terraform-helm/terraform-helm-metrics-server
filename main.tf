locals {
  main_image = regex("^(?:(?P<url>[^/]+))?(?:/(?P<image>[^:]*))??(?::(?P<tag>[^:]*))", var.images.main)
}

resource "helm_release" "this" {
  name             = var.name
  repository       = var.repository
  chart            = var.chart
  namespace        = var.namespace
  create_namespace = var.create_namespace
  version          = var.release_version

  values = var.values

  set {
    name  = "image.repository"
    value = "${local.main_image.url}/${local.main_image.image}"
  }

  set {
    name  = "image.tag"
    value = local.main_image.tag
  }

  set {
    name  = "serviceAccount.name"
    value = "metrics-server"
  }
}

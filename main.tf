locals {
  main_image      = regex("^(?:(?P<url>[^/]+))?(?:/(?P<image>[^:]*))??(?::(?P<tag>[^:]*))", var.images.main)
  main_pre_value  = "image"
  main_set_values = local.main_image != {} ? [{ name = "${local.main_pre_value}.repository", value = "${local.main_image.url}/${local.main_image.image}" }, { name = "${local.main_pre_value}.tag", value = local.main_image.tag }] : []

  set_values = concat(var.set_values, local.main_set_values)

  default_helm_config = {
    name             = var.name
    repository       = var.repository
    chart            = var.chart
    namespace        = var.namespace
    create_namespace = var.create_namespace
    version          = var.release_version
    values           = var.values
  }
  helm_config = merge(local.default_helm_config, var.helm_config)
}

module "helm" {
  source               = "github.com/terraform-helm/terraform-helm?ref=0.1"
  helm_config          = local.helm_config
  set_values           = local.set_values
  set_sensitive_values = var.set_sensitive_values
}


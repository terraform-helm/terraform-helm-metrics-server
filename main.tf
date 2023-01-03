locals {
  set_values = concat(var.set_values, module.main_image.set_values)

  default_helm_config = {
    name       = var.name
    repository = var.repository
    chart      = var.chart
    namespace  = var.namespace
    version    = var.release_version
    values     = var.values
  }

  helm_config = merge(local.default_helm_config, var.helm_config)
}

module "main_image" {
  source     = "github.com/littlejo/terraform-helm-images-set-values?ref=v0.1"
  repo_regex = var.repo_regex
  repo_url   = var.images.main
  pre_value  = "image"
}

module "helm" {
  source               = "github.com/terraform-helm/terraform-helm?ref=v0.2"
  helm_config          = local.helm_config
  set_values           = local.set_values
  set_sensitive_values = var.set_sensitive_values
  create_namespace     = var.create_namespace
}

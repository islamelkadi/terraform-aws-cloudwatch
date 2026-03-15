# Metadata Module Integration
# Provides standardized naming and tagging

module "metadata" {
  source = "github.com/islamelkadi/terraform-aws-metadata?ref=v1.1.1"

  namespace     = var.namespace
  project_name  = var.name
  environment   = var.environment
  resource_type = "alarm"
  region        = var.region
}

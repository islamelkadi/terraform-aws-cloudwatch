# Basic CloudWatch Logs Example

module "lambda_logs" {
  source = "../"

  namespace   = var.namespace
  environment = var.environment
  name        = var.name
  region      = var.region

  log_group_name_override = var.log_group_name_override
  retention_in_days       = var.retention_in_days
  kms_key_id              = var.kms_key_id

  tags = var.tags
}

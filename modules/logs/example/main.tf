# Primary Module Example - This demonstrates the terraform-aws-cloudwatch logs module
# Supporting infrastructure (KMS) is defined in separate files
# to keep this example focused on the module's core functionality.
#
# Basic CloudWatch Logs Example

module "lambda_logs" {
  source = "../"

  namespace   = var.namespace
  environment = var.environment
  name        = var.name
  region      = var.region

  log_group_name_override = var.log_group_name_override
  retention_in_days       = var.retention_in_days
  
  # Direct reference to kms.tf module output
  kms_key_id = module.kms_key.key_id

  tags = var.tags
}

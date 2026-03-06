# Local values for naming and tagging

locals {
  # Use metadata module for standardized naming
  log_group_name_base = module.metadata.resource_prefix

  # Use override if provided, otherwise use metadata naming with optional attributes
  log_group_name = var.log_group_name_override != null ? var.log_group_name_override : (
    length(var.attributes) > 0 ? "${local.log_group_name_base}-${join(var.delimiter, var.attributes)}" : local.log_group_name_base
  )

  # Merge tags with defaults
  tags = merge(
    var.tags,
    module.metadata.security_tags,
    {
      Name   = local.log_group_name
      Module = "terraform-aws-cloudwatch-logs"
    }
  )
}

# Local values for CloudWatch Alarm module

locals {
  # Alarm name
  alarm_name = module.metadata.resource_prefix

  # Merged tags
  tags = merge(
    var.tags,
    module.metadata.security_tags,
    {
      Module = "terraform-aws-cloudwatch/alarms"
    }
  )
}

# CloudWatch Logs Module
# Creates AWS CloudWatch Log Group with security best practices

resource "aws_cloudwatch_log_group" "this" {
  name              = local.log_group_name
  retention_in_days = var.retention_in_days
  kms_key_id        = var.kms_key_id

  tags = local.tags
}

# Optional log stream
resource "aws_cloudwatch_log_stream" "this" {
  for_each = toset(var.log_streams)

  name           = each.value
  log_group_name = aws_cloudwatch_log_group.this.name
}

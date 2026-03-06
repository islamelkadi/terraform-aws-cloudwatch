namespace   = "example"
environment = "dev"
name        = "event-normalizer"
region      = "us-east-1"

log_group_name_override = "/aws/lambda/example-dev-event-normalizer"
retention_in_days       = 30
kms_key_id              = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"

tags = {
  Component = "Lambda"
}

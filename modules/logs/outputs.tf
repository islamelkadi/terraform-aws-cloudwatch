# CloudWatch Logs Module Outputs

output "log_group_name" {
  description = "Name of the CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.this.name
}

output "log_group_arn" {
  description = "ARN of the CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.this.arn
}

output "log_group_id" {
  description = "ID of the CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.this.id
}

output "log_stream_names" {
  description = "Names of the created log streams"
  value       = [for stream in aws_cloudwatch_log_stream.this : stream.name]
}

output "tags" {
  description = "Tags applied to the log group"
  value       = aws_cloudwatch_log_group.this.tags
}

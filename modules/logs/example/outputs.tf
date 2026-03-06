# Example Outputs

output "log_group_name" {
  description = "Name of the CloudWatch log group"
  value       = module.lambda_logs.log_group_name
}

output "log_group_arn" {
  description = "ARN of the CloudWatch log group"
  value       = module.lambda_logs.log_group_arn
}

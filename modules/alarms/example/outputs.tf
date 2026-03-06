# Example Outputs

output "alarm_arn" {
  description = "ARN of the CloudWatch alarm"
  value       = module.lambda_errors.alarm_arn
}

output "alarm_name" {
  description = "Name of the CloudWatch alarm"
  value       = module.lambda_errors.alarm_name
}

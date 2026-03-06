# CloudWatch Alarm Module Outputs

output "alarm_arn" {
  description = "ARN of the CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.this.arn
}

output "alarm_id" {
  description = "ID of the CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.this.id
}

output "alarm_name" {
  description = "Name of the CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.this.alarm_name
}

output "tags" {
  description = "Tags applied to the alarm"
  value       = aws_cloudwatch_metric_alarm.this.tags
}

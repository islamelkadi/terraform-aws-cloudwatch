# Basic CloudWatch Alarm Example

module "lambda_errors" {
  source = "../"

  namespace   = var.namespace
  environment = var.environment
  name        = var.name
  region      = var.region

  alarm_description   = var.alarm_description
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace_metric    = var.namespace_metric
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  treat_missing_data  = var.treat_missing_data

  dimensions = var.dimensions

  # SNS notifications: pass existing SNS topic ARNs to receive alarm state changes.
  # This module does not create SNS topics — create them separately and pass their ARNs here.
  # alarm_actions  → notified when alarm enters ALARM state
  # ok_actions     → notified when alarm returns to OK state
  alarm_actions = var.alarm_actions
  ok_actions    = var.ok_actions

  tags = var.tags
}

# CloudWatch Alarm Module
# Creates AWS CloudWatch alarms with SNS notifications

resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = local.alarm_name
  alarm_description   = var.alarm_description
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace_metric
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  treat_missing_data  = var.treat_missing_data

  # Dimensions
  dimensions = var.dimensions

  # Actions
  alarm_actions             = var.alarm_actions
  ok_actions                = var.ok_actions
  insufficient_data_actions = var.insufficient_data_actions

  # Extended statistic (for percentiles)
  extended_statistic = var.extended_statistic

  # Datapoints to alarm
  datapoints_to_alarm = var.datapoints_to_alarm

  # Unit
  unit = var.unit

  tags = local.tags
}

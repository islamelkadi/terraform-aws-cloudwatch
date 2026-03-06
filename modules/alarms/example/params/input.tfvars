namespace   = "example"
environment = "dev"
name        = "lambda-errors"
region      = "us-east-1"

alarm_description   = "Alert when Lambda error count exceeds threshold"
comparison_operator = "GreaterThanThreshold"
evaluation_periods  = 2
metric_name         = "Errors"
namespace_metric    = "AWS/Lambda"
period              = 300
statistic           = "Sum"
threshold           = 10
treat_missing_data  = "notBreaching"

dimensions = {
  FunctionName = "my-lambda-function"
}

alarm_actions = ["arn:aws:sns:us-east-1:123456789012:cloudwatch-alarms"]
ok_actions    = ["arn:aws:sns:us-east-1:123456789012:cloudwatch-alarms"]

tags = {
  Purpose = "Lambda monitoring"
}

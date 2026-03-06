variable "namespace" {
  description = "Namespace (organization/team name)"
  type        = string
  default     = "example"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "name" {
  description = "Name for the alarm"
  type        = string
  default     = "lambda-errors"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "alarm_description" {
  description = "Description of the alarm"
  type        = string
  default     = "Alert when Lambda error count exceeds threshold"
}

variable "comparison_operator" {
  description = "Comparison operator for the alarm"
  type        = string
  default     = "GreaterThanThreshold"
}

variable "evaluation_periods" {
  description = "Number of evaluation periods"
  type        = number
  default     = 2
}

variable "metric_name" {
  description = "CloudWatch metric name"
  type        = string
  default     = "Errors"
}

variable "namespace_metric" {
  description = "CloudWatch metric namespace"
  type        = string
  default     = "AWS/Lambda"
}

variable "period" {
  description = "Evaluation period in seconds"
  type        = number
  default     = 300
}

variable "statistic" {
  description = "Statistic to apply"
  type        = string
  default     = "Sum"
}

variable "threshold" {
  description = "Alarm threshold"
  type        = number
  default     = 10
}

variable "treat_missing_data" {
  description = "How to treat missing data"
  type        = string
  default     = "notBreaching"
}

variable "dimensions" {
  description = "CloudWatch metric dimensions"
  type        = map(string)
  default = {
    FunctionName = "my-lambda-function"
  }
}

variable "alarm_actions" {
  description = "List of ARNs to notify on alarm"
  type        = list(string)
  default     = ["arn:aws:sns:us-east-1:123456789012:cloudwatch-alarms"]
}

variable "ok_actions" {
  description = "List of ARNs to notify on OK"
  type        = list(string)
  default     = ["arn:aws:sns:us-east-1:123456789012:cloudwatch-alarms"]
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default = {
    Purpose = "Lambda monitoring"
  }
}

# CloudWatch Alarm Module Variables

# Metadata variables for consistent naming
variable "namespace" {
  description = "Namespace (organization/team name)"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod"
  }
}

variable "name" {
  description = "Name of the CloudWatch alarm"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "AWS region where resources will be created"
  type        = string
}

# CloudWatch Alarm specific variables
variable "alarm_description" {
  description = "Description of the alarm"
  type        = string
  default     = ""
}

variable "comparison_operator" {
  description = "Arithmetic operation to use when comparing statistic and threshold"
  type        = string

  validation {
    condition = contains([
      "GreaterThanOrEqualToThreshold",
      "GreaterThanThreshold",
      "LessThanThreshold",
      "LessThanOrEqualToThreshold",
      "LessThanLowerOrGreaterThanUpperThreshold",
      "LessThanLowerThreshold",
      "GreaterThanUpperThreshold"
    ], var.comparison_operator)
    error_message = "Invalid comparison operator"
  }
}

variable "evaluation_periods" {
  description = "Number of periods over which data is compared to the threshold"
  type        = number
  default     = 1

  validation {
    condition     = var.evaluation_periods >= 1
    error_message = "Evaluation periods must be at least 1"
  }
}

variable "metric_name" {
  description = "Name of the metric"
  type        = string
}

variable "namespace_metric" {
  description = "Namespace for the metric (e.g., AWS/EC2, AWS/Lambda)"
  type        = string
}

variable "period" {
  description = "Period in seconds over which the statistic is applied"
  type        = number
  default     = 300

  validation {
    condition     = var.period >= 10
    error_message = "Period must be at least 10 seconds"
  }
}

variable "statistic" {
  description = "Statistic to apply to the metric"
  type        = string
  default     = "Average"

  validation {
    condition     = contains(["SampleCount", "Average", "Sum", "Minimum", "Maximum"], var.statistic)
    error_message = "Invalid statistic"
  }
}

variable "threshold" {
  description = "Value to compare the statistic against"
  type        = number
}

variable "treat_missing_data" {
  description = "How to treat missing data (notBreaching, breaching, ignore, missing)"
  type        = string
  default     = "notBreaching"

  validation {
    condition     = contains(["notBreaching", "breaching", "ignore", "missing"], var.treat_missing_data)
    error_message = "Invalid treat_missing_data value"
  }
}

variable "dimensions" {
  description = "Dimensions for the metric"
  type        = map(string)
  default     = {}
}

variable "alarm_actions" {
  description = "List of ARNs to notify when alarm transitions to ALARM state"
  type        = list(string)
  default     = []
}

variable "ok_actions" {
  description = "List of ARNs to notify when alarm transitions to OK state"
  type        = list(string)
  default     = []
}

variable "insufficient_data_actions" {
  description = "List of ARNs to notify when alarm transitions to INSUFFICIENT_DATA state"
  type        = list(string)
  default     = []
}

variable "extended_statistic" {
  description = "Percentile statistic (e.g., p99, p95)"
  type        = string
  default     = null
}

variable "datapoints_to_alarm" {
  description = "Number of datapoints that must be breaching to trigger alarm"
  type        = number
  default     = null
}

variable "unit" {
  description = "Unit for the metric"
  type        = string
  default     = null
}

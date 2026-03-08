variable "namespace" {
  description = "Namespace (organization/team name)"
  type        = string
  default     = "ws"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "name" {
  description = "Name for the log group"
  type        = string
  default     = "event-normalizer"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "log_group_name_override" {
  description = "Override the auto-generated log group name"
  type        = string
  default     = "/aws/lambda/ws-dev-event-normalizer"
}

variable "retention_in_days" {
  description = "Log retention period in days"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default = {
    Component = "Lambda"
  }
}

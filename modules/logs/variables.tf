# CloudWatch Logs Module Variables

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
  description = "Name of the log group"
  type        = string
}

variable "attributes" {
  description = "Additional attributes for naming"
  type        = list(string)
  default     = []
}

variable "delimiter" {
  description = "Delimiter to use between name components"
  type        = string
  default     = "-"
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}

# CloudWatch Logs configuration
variable "retention_in_days" {
  description = "Number of days to retain log events"
  type        = number
  default     = 30

  validation {
    condition = contains([
      0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653
    ], var.retention_in_days)
    error_message = "Retention days must be a valid CloudWatch Logs retention period or 0 for never expire"
  }
}

variable "kms_key_id" {
  description = "ARN of the KMS key to use for log encryption. If not provided, logs are encrypted with AWS managed key"
  type        = string
  default     = null
}

variable "log_streams" {
  description = "List of log stream names to create in the log group"
  type        = list(string)
  default     = []
}

variable "log_group_name_override" {
  description = "Override the generated log group name with a custom name. Use this for AWS service-specific naming requirements (e.g., /aws/lambda/function-name)"
  type        = string
  default     = null
}

variable "region" {
  description = "AWS region where resources will be created"
  type        = string
}

# Security Controls
variable "security_controls" {
  description = "Security controls configuration from metadata module"
  type = object({
    encryption = object({
      require_kms_customer_managed  = bool
      require_encryption_at_rest    = bool
      require_encryption_in_transit = bool
      enable_kms_key_rotation       = bool
    })
    logging = object({
      require_cloudwatch_logs = bool
      min_log_retention_days  = number
      require_access_logging  = bool
      require_flow_logs       = bool
    })
    monitoring = object({
      enable_xray_tracing         = bool
      enable_enhanced_monitoring  = bool
      enable_performance_insights = bool
      require_cloudtrail          = bool
    })
    network = object({
      require_private_subnets = bool
      require_vpc_endpoints   = bool
      block_public_ingress    = bool
      require_imdsv2          = bool
    })
    compliance = object({
      enable_point_in_time_recovery = bool
      require_reserved_concurrency  = bool
      enable_deletion_protection    = bool
    })
    data_protection = object({
      require_versioning  = bool
      require_mfa_delete  = bool
      require_backup      = bool
      require_lifecycle   = bool
      block_public_access = bool
      require_replication = bool
    })
  })
  default = null
}

variable "security_control_overrides" {
  description = "Override specific security controls with documented justification"
  type = object({
    disable_kms_requirement           = optional(bool, false)
    disable_log_retention_requirement = optional(bool, false)
    justification                     = optional(string, "")
  })
  default = {
    disable_kms_requirement           = false
    disable_log_retention_requirement = false
    justification                     = ""
  }
}

# Terraform AWS CloudWatch Logs Module

Production-ready AWS CloudWatch Logs module with comprehensive security controls, KMS encryption, configurable retention, and log stream management. Provides centralized logging infrastructure for AWS services and applications.

## Table of Contents

- [Security Controls](#security-controls)
- [Features](#features)
- [Usage Examples](#usage-examples)
- [Requirements](#requirements)
- [Examples](#examples)

## Security Controls

This module implements security controls based on the metadata module's security policy. Controls can be selectively overridden with documented business justification.

### Available Security Control Overrides

| Override Flag | Control | Default | Common Use Case |
|--------------|---------|---------|-----------------|
| `disable_kms_requirement` | KMS Customer-Managed Encryption | `false` | Development logs with no sensitive data |
| `disable_log_retention_requirement` | Minimum Log Retention Period | `false` | Development environments with short-term log needs |

### Security Control Architecture

**Two-Layer Design:**
1. **Metadata Module** (Policy Layer): Defines security requirements based on environment
2. **CloudWatch Logs Module** (Enforcement Layer): Validates configuration against policy

**Override Pattern:**
```hcl
security_control_overrides = {
  disable_log_retention_requirement = true
  justification = "Development environment, 7-day retention acceptable for cost optimization"
}
```

### Best Practices

1. **Production Logs**: Always use KMS customer-managed keys and minimum 90-day retention
2. **Development Logs**: Overrides acceptable for cost optimization with justification
3. **Sensitive Data**: Always encrypt logs containing PII or financial data
4. **Audit Trail**: All overrides require `justification` field for compliance
5. **Review Cycle**: Quarterly review of all active overrides

## Features

- **KMS Encryption**: Customer-managed key encryption for log data at rest
- **Configurable Retention**: Support for all CloudWatch Logs retention periods (1 day to 10 years)
- **Log Stream Management**: Automatic creation of log streams within log groups
- **Custom Naming**: Support for AWS service-specific naming requirements
- **Flexible Configuration**: Override generated names for service integrations
- **Consistent Naming**: Integration with metadata module for standardized resource naming
- **Zero Retention**: Support for never-expiring logs (retention = 0)

## Usage Examples

### Example 1: Basic Log Group with Security Controls

```hcl
module "metadata" {
  source = "github.com/islamelkadi/terraform-aws-metadata"
  
  namespace   = "example"
  environment = "prod"
  name        = "corporate-actions"
  region      = "us-east-1"
}

module "app_logs" {
  source = "github.com/islamelkadi/terraform-aws-cloudwatch//modules/logs"
  
  namespace   = module.metadata.namespace
  environment = module.metadata.environment
  name        = "application"
  region      = module.metadata.region
  
  retention_in_days = 90
  kms_key_id        = module.kms.key_arn
  
  log_streams = [
    "api-requests",
    "background-jobs",
    "errors"
  ]
  
  security_controls = module.metadata.security_controls
  
  tags = module.metadata.tags
}
```

### Example 2: Lambda Function Logs with Custom Naming

```hcl
module "lambda_logs" {
  source = "github.com/islamelkadi/terraform-aws-cloudwatch//modules/logs"
  
  namespace   = "example"
  environment = "prod"
  name        = "event-normalizer"
  attributes  = ["lambda"]
  region      = "us-east-1"
  
  # AWS Lambda requires specific log group naming
  log_group_name_override = "/aws/lambda/${module.lambda.function_name}"
  
  retention_in_days = 365
  kms_key_id        = module.kms.key_arn
  
  security_controls = module.metadata.security_controls
  
  tags = module.metadata.tags
}
```

### Example 3: Production Logs with Maximum Retention

```hcl
module "audit_logs" {
  source = "github.com/islamelkadi/terraform-aws-cloudwatch//modules/logs"
  
  namespace   = "example"
  environment = "prod"
  name        = "audit-trail"
  region      = "us-east-1"
  
  # Maximum retention for compliance
  retention_in_days = 3653  # 10 years
  kms_key_id        = module.kms.key_arn
  
  log_streams = [
    "authentication",
    "authorization",
    "data-access",
    "configuration-changes"
  ]
  
  security_controls = module.metadata.security_controls
  
  tags = merge(
    module.metadata.tags,
    {
      Compliance = "FCAC"
      Criticality = "High"
      DataClassification = "Confidential"
    }
  )
}
```

### Example 4: Development Logs with Cost Optimization

```hcl
module "dev_logs" {
  source = "github.com/islamelkadi/terraform-aws-cloudwatch//modules/logs"
  
  namespace   = "example"
  environment = "dev"
  name        = "development"
  region      = "us-east-1"
  
  # Short retention for cost savings
  retention_in_days = 7
  kms_key_id        = null  # Use AWS managed key
  
  log_streams = ["application", "debug"]
  
  security_controls = module.metadata.security_controls
  
  # Override with justification
  security_control_overrides = {
    disable_kms_requirement           = true
    disable_log_retention_requirement = true
    justification = "Development environment, no sensitive data, 7-day retention acceptable for cost optimization"
  }
  
  tags = module.metadata.tags
}
```

## Environment-Based Security Controls

Security controls are automatically applied based on the environment through the [terraform-aws-metadata](https://github.com/islamelkadi/terraform-aws-metadata?tab=readme-ov-file#security-profiles){:target="_blank"} module's security profiles:

| Control | Dev | Staging | Prod |
|---------|-----|---------|------|
| KMS encryption for logs | Optional | Required | Required |
| Log retention | 7 days | 90 days | 365 days |
| Log stream management | Optional | Recommended | Required |

For full details on security profiles and how controls vary by environment, see the <a href="https://github.com/islamelkadi/terraform-aws-metadata?tab=readme-ov-file#security-profiles" target="_blank">Security Profiles</a> documentation.

<!-- BEGIN_TF_DOCS -->


## Usage

```hcl
# Basic CloudWatch Logs Example

module "lambda_logs" {
  source = "../"

  namespace   = var.namespace
  environment = var.environment
  name        = var.name
  region      = var.region

  log_group_name_override = var.log_group_name_override
  retention_in_days       = var.retention_in_days
  kms_key_id              = var.kms_key_id

  tags = var.tags
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.14.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.34 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.34 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_metadata"></a> [metadata](#module\_metadata) | github.com/islamelkadi/terraform-aws-metadata | v1.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_stream.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes for naming | `list(string)` | `[]` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to use between name components | `string` | `"-"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev, staging, prod) | `string` | n/a | yes |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | ARN of the KMS key to use for log encryption. If not provided, logs are encrypted with AWS managed key | `string` | `null` | no |
| <a name="input_log_group_name_override"></a> [log\_group\_name\_override](#input\_log\_group\_name\_override) | Override the generated log group name with a custom name. Use this for AWS service-specific naming requirements (e.g., /aws/lambda/function-name) | `string` | `null` | no |
| <a name="input_log_streams"></a> [log\_streams](#input\_log\_streams) | List of log stream names to create in the log group | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the log group | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace (organization/team name) | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region where resources will be created | `string` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Number of days to retain log events | `number` | `30` | no |
| <a name="input_security_control_overrides"></a> [security\_control\_overrides](#input\_security\_control\_overrides) | Override specific security controls with documented justification | <pre>object({<br/>    disable_kms_requirement           = optional(bool, false)<br/>    disable_log_retention_requirement = optional(bool, false)<br/>    justification                     = optional(string, "")<br/>  })</pre> | <pre>{<br/>  "disable_kms_requirement": false,<br/>  "disable_log_retention_requirement": false,<br/>  "justification": ""<br/>}</pre> | no |
| <a name="input_security_controls"></a> [security\_controls](#input\_security\_controls) | Security controls configuration from metadata module | <pre>object({<br/>    encryption = object({<br/>      require_kms_customer_managed  = bool<br/>      require_encryption_at_rest    = bool<br/>      require_encryption_in_transit = bool<br/>      enable_kms_key_rotation       = bool<br/>    })<br/>    logging = object({<br/>      require_cloudwatch_logs = bool<br/>      min_log_retention_days  = number<br/>      require_access_logging  = bool<br/>      require_flow_logs       = bool<br/>    })<br/>    monitoring = object({<br/>      enable_xray_tracing         = bool<br/>      enable_enhanced_monitoring  = bool<br/>      enable_performance_insights = bool<br/>      require_cloudtrail          = bool<br/>    })<br/>    network = object({<br/>      require_private_subnets = bool<br/>      require_vpc_endpoints   = bool<br/>      block_public_ingress    = bool<br/>      require_imdsv2          = bool<br/>    })<br/>    compliance = object({<br/>      enable_point_in_time_recovery = bool<br/>      require_reserved_concurrency  = bool<br/>      enable_deletion_protection    = bool<br/>    })<br/>    data_protection = object({<br/>      require_versioning  = bool<br/>      require_mfa_delete  = bool<br/>      require_backup      = bool<br/>      require_lifecycle   = bool<br/>      block_public_access = bool<br/>      require_replication = bool<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_log_group_arn"></a> [log\_group\_arn](#output\_log\_group\_arn) | ARN of the CloudWatch Log Group |
| <a name="output_log_group_id"></a> [log\_group\_id](#output\_log\_group\_id) | ID of the CloudWatch Log Group |
| <a name="output_log_group_name"></a> [log\_group\_name](#output\_log\_group\_name) | Name of the CloudWatch Log Group |
| <a name="output_log_stream_names"></a> [log\_stream\_names](#output\_log\_stream\_names) | Names of the created log streams |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags applied to the log group |

## Example

See [example/](example/) for a complete working example with all features.

## License

MIT Licensed. See [LICENSE](LICENSE) for full details.
<!-- END_TF_DOCS -->

## Examples

See [example/](example/) for a complete working example.


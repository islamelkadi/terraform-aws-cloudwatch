# Terraform AWS CloudWatch Alarms Module

Production-ready AWS CloudWatch Alarms module for monitoring metrics and triggering notifications. Supports standard and percentile statistics with flexible threshold configuration.

## Table of Contents

- [Features](#features)
- [Usage Example](#usage-example)
- [Requirements](#requirements)

## Features

- **Flexible Metrics**: Support for any CloudWatch metric (AWS services or custom)
- **Multiple Statistics**: Standard statistics (Average, Sum, Min, Max) and percentiles (p99, p95, etc.)
- **Action Integration**: SNS topic notifications for alarm state changes
- **Missing Data Handling**: Configurable behavior for missing data points
- **Consistent Naming**: Integration with metadata module for standardized resource naming

## Security

### Environment-Based Security Controls

Security controls are automatically applied based on the environment through the [terraform-aws-metadata](https://github.com/islamelkadi/terraform-aws-metadata?tab=readme-ov-file#security-profiles) module's security profiles:

| Control | Dev | Staging | Prod |
|---------|-----|---------|------|
| Metric alarms | Optional | Recommended | Required |
| SNS notifications | Optional | Recommended | Required |
| Evaluation periods | Relaxed | Standard | Strict |

For full details on security profiles and how controls vary by environment, see the [Security Profiles](https://github.com/islamelkadi/terraform-aws-metadata?tab=readme-ov-file#security-profiles) documentation.

## Usage Example

```hcl
module "lambda_errors_alarm" {
  source = "github.com/islamelkadi/terraform-aws-cloudwatch//modules/alarms"
  
  namespace   = "example"
  environment = "prod"
  name        = "lambda-errors"
  region      = "us-east-1"
  
  alarm_description   = "Alert when Lambda function errors exceed threshold"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  threshold           = 5
  
  namespace_metric = "AWS/Lambda"
  metric_name      = "Errors"
  statistic        = "Sum"
  period           = 300
  
  dimensions = {
    FunctionName = module.lambda.function_name
  }
  
  alarm_actions = [module.sns_topic.arn]
  
  tags = {
    Tier = "Monitoring"
  }
}
```

<!-- BEGIN_TF_DOCS -->

## Usage

```hcl
# Basic CloudWatch Alarm Example

module "lambda_errors" {
  source = "github.com/islamelkadi/terraform-aws-cloudwatch//modules/alarms"

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
| [aws_cloudwatch_metric_alarm.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_actions"></a> [alarm\_actions](#input\_alarm\_actions) | List of ARNs to notify when alarm transitions to ALARM state | `list(string)` | `[]` | no |
| <a name="input_alarm_description"></a> [alarm\_description](#input\_alarm\_description) | Description of the alarm | `string` | `""` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes for naming | `list(string)` | `[]` | no |
| <a name="input_comparison_operator"></a> [comparison\_operator](#input\_comparison\_operator) | Arithmetic operation to use when comparing statistic and threshold | `string` | n/a | yes |
| <a name="input_datapoints_to_alarm"></a> [datapoints\_to\_alarm](#input\_datapoints\_to\_alarm) | Number of datapoints that must be breaching to trigger alarm | `number` | `null` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to use between name components | `string` | `"-"` | no |
| <a name="input_dimensions"></a> [dimensions](#input\_dimensions) | Dimensions for the metric | `map(string)` | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev, staging, prod) | `string` | n/a | yes |
| <a name="input_evaluation_periods"></a> [evaluation\_periods](#input\_evaluation\_periods) | Number of periods over which data is compared to the threshold | `number` | `1` | no |
| <a name="input_extended_statistic"></a> [extended\_statistic](#input\_extended\_statistic) | Percentile statistic (e.g., p99, p95) | `string` | `null` | no |
| <a name="input_insufficient_data_actions"></a> [insufficient\_data\_actions](#input\_insufficient\_data\_actions) | List of ARNs to notify when alarm transitions to INSUFFICIENT\_DATA state | `list(string)` | `[]` | no |
| <a name="input_metric_name"></a> [metric\_name](#input\_metric\_name) | Name of the metric | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the CloudWatch alarm | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace (organization/team name) | `string` | n/a | yes |
| <a name="input_namespace_metric"></a> [namespace\_metric](#input\_namespace\_metric) | Namespace for the metric (e.g., AWS/EC2, AWS/Lambda) | `string` | n/a | yes |
| <a name="input_ok_actions"></a> [ok\_actions](#input\_ok\_actions) | List of ARNs to notify when alarm transitions to OK state | `list(string)` | `[]` | no |
| <a name="input_period"></a> [period](#input\_period) | Period in seconds over which the statistic is applied | `number` | `300` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region where resources will be created | `string` | n/a | yes |
| <a name="input_statistic"></a> [statistic](#input\_statistic) | Statistic to apply to the metric | `string` | `"Average"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to resources | `map(string)` | `{}` | no |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | Value to compare the statistic against | `number` | n/a | yes |
| <a name="input_treat_missing_data"></a> [treat\_missing\_data](#input\_treat\_missing\_data) | How to treat missing data (notBreaching, breaching, ignore, missing) | `string` | `"notBreaching"` | no |
| <a name="input_unit"></a> [unit](#input\_unit) | Unit for the metric | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alarm_arn"></a> [alarm\_arn](#output\_alarm\_arn) | ARN of the CloudWatch alarm |
| <a name="output_alarm_id"></a> [alarm\_id](#output\_alarm\_id) | ID of the CloudWatch alarm |
| <a name="output_alarm_name"></a> [alarm\_name](#output\_alarm\_name) | Name of the CloudWatch alarm |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags applied to the alarm |

## Example

See [example/](example/) for a complete working example with all features.


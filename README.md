# Terraform AWS CloudWatch Module

Reusable Terraform module for AWS CloudWatch alarms and log groups.

## Prerequisites

This module is designed for macOS. The following must already be installed on your machine:
- Python 3 and pip
- [Kiro](https://kiro.dev) and Kiro CLI
- [Homebrew](https://brew.sh)

To install the remaining development tools, run:

```bash
make bootstrap
```

This will install/upgrade: tfenv, Terraform (via tfenv), tflint, terraform-docs, checkov, and pre-commit.

## Submodules

| Submodule | Description |
|-----------|-------------|
| [alarms](modules/alarms/) | CloudWatch metric alarms with SNS notifications |
| [logs](modules/logs/) | CloudWatch Log Groups with KMS encryption and retention |

## Usage

```hcl
module "lambda_errors" {
  source = "path/to/terraform-aws-cloudwatch/modules/alarms"

  namespace   = "example"
  environment = "prod"
  name        = "lambda-errors"
  region      = "us-east-1"

  alarm_description   = "Alert when Lambda errors exceed threshold"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "Errors"
  namespace_metric    = "AWS/Lambda"
  period              = 300
  statistic           = "Sum"
  threshold           = 10

  dimensions = {
    FunctionName = "my-function"
  }

  alarm_actions = [var.sns_topic_arn]
  tags          = var.tags
}

module "lambda_logs" {
  source = "path/to/terraform-aws-cloudwatch/modules/logs"

  namespace   = "example"
  environment = "prod"
  name        = "event-normalizer"
  region      = "us-east-1"

  log_group_name_override = "/aws/lambda/ws-prod-event-normalizer"
  retention_in_days       = 365
  kms_key_id              = var.kms_key_arn

  tags = var.tags
}
```

## Security Controls

Implements controls for FSBP, CIS, NIST 800-53/171, and PCI DSS v4.0:

- KMS encryption for CloudWatch Logs
- Configurable retention periods (365 days recommended for production)
- Metric alarms for critical events
- SNS integration for notifications
- Security control overrides with audit justification

## Module Structure

```
terraform-aws-cloudwatch/
├── modules/
│   ├── alarms/
│   │   ├── example/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   │   └── params/input.tfvars
│   │   └── ...
│   └── logs/
│       ├── example/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   ├── outputs.tf
│       │   └── params/input.tfvars
│       └── ...
└── README.md
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.14.3 |
| aws | >= 6.34 |

## Environment-Based Security Controls

Security controls are automatically applied based on the environment through the [terraform-aws-metadata](https://github.com/islamelkadi/terraform-aws-metadata?tab=readme-ov-file#security-profiles){:target="_blank"} module's security profiles:

| Control | Dev | Staging | Prod |
|---------|-----|---------|------|
| KMS encryption for logs | Optional | Required | Required |
| Log retention | 7 days | 90 days | 365 days |
| Metric alarms | Optional | Recommended | Required |
| SNS notifications | Optional | Recommended | Required |

For full details on security profiles and how controls vary by environment, see the <a href="https://github.com/islamelkadi/terraform-aws-metadata?tab=readme-ov-file#security-profiles" target="_blank">Security Profiles</a> documentation.

## MCP Servers

This module includes two [Model Context Protocol (MCP)](https://modelcontextprotocol.io/) servers configured in `.kiro/settings/mcp.json` for use with Kiro:

| Server | Package | Description |
|--------|---------|-------------|
| `aws-docs` | `awslabs.aws-documentation-mcp-server@latest` | Provides access to AWS documentation for contextual lookups of service features, API references, and best practices. |
| `terraform` | `awslabs.terraform-mcp-server@latest` | Enables Terraform operations (init, validate, plan, fmt, tflint) directly from the IDE with auto-approved commands for common workflows. |

Both servers run via `uvx` and require no additional installation beyond the [bootstrap](#prerequisites) step.

<!-- BEGIN_TF_DOCS -->


## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.

## License

MIT Licensed. See [LICENSE](LICENSE) for full details.
<!-- END_TF_DOCS -->

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

## Security

### Security Controls

Implements controls for FSBP, CIS, NIST 800-53/171, and PCI DSS v4.0:

- KMS encryption for CloudWatch Logs
- Configurable retention periods (365 days recommended for production)
- Metric alarms for critical events
- SNS integration for notifications
- Security control overrides with audit justification

### Environment-Based Security Controls

Security controls are automatically applied based on the environment through the [terraform-aws-metadata](https://github.com/islamelkadi/terraform-aws-metadata?tab=readme-ov-file#security-profiles) module's security profiles:

| Control | Dev | Staging | Prod |
|---------|-----|---------|------|
| KMS encryption for logs | Optional | Required | Required |
| Log retention | 7 days | 90 days | 365 days |
| Metric alarms | Optional | Recommended | Required |
| SNS notifications | Optional | Recommended | Required |

For full details on security profiles and how controls vary by environment, see the [Security Profiles](https://github.com/islamelkadi/terraform-aws-metadata?tab=readme-ov-file#security-profiles) documentation.

### Security Scan Suppressions

This module suppresses certain Checkov security checks that are either not applicable to example/demo code or represent optional features. The following checks are suppressed in `.checkov.yaml`:

**Module Source Versioning (CKV_TF_1, CKV_TF_2)**
- Suppressed because we use semantic version tags (`?ref=v1.0.0`) instead of commit hashes for better maintainability and readability
- Semantic versioning is a valid and widely-accepted versioning strategy for stable releases

**KMS IAM Policies (CKV_AWS_111, CKV_AWS_356, CKV_AWS_109)**
- Suppressed in example code where KMS modules use flexible IAM policies for demonstration purposes
- Production deployments should customize KMS policies based on specific security requirements and apply least privilege principles

## Submodules

| Submodule | Description |
|-----------|-------------|
| [alarms](modules/alarms/) | CloudWatch metric alarms with SNS notifications |
| [logs](modules/logs/) | CloudWatch Log Groups with KMS encryption and retention |

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

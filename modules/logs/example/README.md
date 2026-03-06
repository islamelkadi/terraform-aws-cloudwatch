# Basic CloudWatch Logs Example

This example creates a single CloudWatch Log Group for a Lambda function with KMS encryption using a fictitious KMS key ARN.

## Usage

```bash
terraform init
terraform plan -var-file=params/input.tfvars
terraform apply -var-file=params/input.tfvars
```

## What This Example Creates

- CloudWatch Log Group with configurable retention and KMS encryption

## Clean Up

```bash
terraform destroy -var-file=params/input.tfvars
```

# Basic CloudWatch Alarm Example

This example creates a single CloudWatch alarm monitoring Lambda function errors using fictitious SNS topic ARNs.

## Usage

```bash
terraform init
terraform plan -var-file=params/input.tfvars
terraform apply -var-file=params/input.tfvars
```

## What This Example Creates

- CloudWatch alarm for Lambda error count with SNS notifications

## Clean Up

```bash
terraform destroy -var-file=params/input.tfvars
```

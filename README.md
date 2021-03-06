# AWS Replicated Secret Module

## ARCHIVED
This functionality is now natively supported by the [aws_secretsmanager_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) resource (see the `replica` block), so this module is now archived and will have no further changes.

A module that is similar to the aws_secretsmanager_secret resource, but adds support for cross-region replication. It utilizes CloudFormation (via the [aws_cloudformation_stack](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) resource) to create the secret.

This module will become obsolete once [this issue](https://github.com/hashicorp/terraform-provider-aws/issues/17943) in the Terraform AWS provider is resolved.

## Variables
The module accepts the same variables as the [aws_secretsmanager_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) resource, except for the `name_prefix` variable (as this is an internal Terraform tool that does not map to a CloudFormation parameter for a secret). In addition, it accepts the `replica_regions` variable, which is a list of maps where each map has keys `region` (e.g. `us-west-2`) and `kms_key_id` (leave as `null` to use the default KMS key).

**Note:** We experimented with using Terraform's `timestamp()` and `random_id` functions to try to replicate the `name_prefix` functionality, but it was causing CloudFormation to re-create the stack on each apply, which deletes and re-creates the secret. If you have a pull request to fix this, it would be welcomed.

## Outputs
The module returns the same outputs as the [aws_secretsmanager_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) resource, with the addition of the `replica_regions` output (same as the input variable) and the `replica_arns` output (a map of region names to replicated secret ARNs, also including the region/ARN of the secret in the primary region).

## Warning
Due to the use of CloudFormation, Terraform can show an "update" to the secret, when in reality CloudFormation will delete and re-create it. Be very careful so you don't lose your secret values!

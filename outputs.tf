output "arn" {
  description = "Amazon Resource Name (ARN) of the secret."
  value       = aws_cloudformation_stack.secret.outputs.arn
}

output "id" {
  description = "Amazon Resource Name (ARN) of the secret."
  value       = data.aws_secretsmanager_secret.secret.id
}

output "tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = data.aws_secretsmanager_secret.secret.tags
}

output "policy" {
  description = "Rotation rules if rotation is enabled."
  value       = data.aws_secretsmanager_secret.secret.policy
}

output "replica_arns" {
  description = "The ARNs of the replica secrets (also includes the ARN of the secret in the primary region). Keys are region names, values are ARNs."
  value = merge({
    for replica in var.replica_regions :
    replica.region => "arn:${data.aws_arn.secret.partition}:${data.aws_arn.secret.service}:${replica.region}:${data.aws_arn.secret.account}:${data.aws_arn.secret.resource}"
    }, {
    (data.aws_region.current.name) = aws_cloudformation_stack.secret.outputs.arn
  })
}

output "primary_region" {
  description = "The region that the initial secret was created in and is replicated from."
  value       = data.aws_region.current.name
}

// Also output all of the input variables
output "name" {
  description = "Specifies the friendly name of the new secret. The secret name can consist of uppercase letters, lowercase letters, digits, and any of the following characters: `/_+=.@-`. Conflicts with `name_prefix`."
  value       = var.name
}

output "description" {
  description = "A description of the secret."
  value       = data.aws_secretsmanager_secret.secret.description
}

output "kms_key_id" {
  description = "Specifies the ARN or Id of the AWS KMS customer master key (CMK) to be used to encrypt the secret values in the versions stored in this secret. If you don't specify this value, then Secrets Manager defaults to using the AWS account's default CMK (the one named `aws/secretsmanager`). If the default KMS CMK with that name doesn't yet exist, then AWS Secrets Manager creates it for you automatically the first time."
  value       = data.aws_secretsmanager_secret.secret.kms_key_id
}

output "recovery_window_in_days" {
  description = "Specifies the number of days that AWS Secrets Manager waits before it can delete the secret. This value can be `0` to force deletion without recovery or range from `7` to `30` days. The default value is `30`."
  value       = var.recovery_window_in_days
}

output "tags" {
  description = "Specifies a key-value map of user-defined tags that are attached to the secret. If configured with a provider `default_tags` configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  value       = var.tags
}

output "replica_regions" {
  description = "A list of regions to replicate the secret to. Each element in the list must be a map with `kms_key_id` and `region` keys."
  value       = var.replica_regions
}

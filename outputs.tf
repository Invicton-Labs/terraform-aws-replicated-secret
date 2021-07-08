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
  description = "Same as the corresponding input variable."
  value       = var.name
}

output "description" {
  description = "A description of the secret."
  value       = data.aws_secretsmanager_secret.secret.description
}

output "kms_key_id" {
  description = "The ID of the KMS key that was used to encrypt the secret."
  value       = data.aws_secretsmanager_secret.secret.kms_key_id
}

output "recovery_window_in_days" {
  description = "Same as the corresponding input variable."
  value       = var.recovery_window_in_days
}

output "tags" {
  description = "Same as the corresponding input variable."
  value       = var.tags
}

output "replica_regions" {
  description = "Same as the corresponding input variable."
  value       = var.replica_regions
}

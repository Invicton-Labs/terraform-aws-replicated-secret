output "arn" {
  description = "Amazon Resource Name (ARN) of the secret."
  value       = aws_cloudformation_stack.secret.outputs.arn
}

output "id" {
  description = "Amazon Resource Name (ARN) of the secret."
  value       = data.aws_secretsmanager_secret.secret.id
}

output "rotation_enabled" {
  description = "Specifies whether automatic rotation is enabled for this secret."
  value       = data.aws_secretsmanager_secret.secret.rotation_enabled
}

output "tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = data.aws_secretsmanager_secret.secret.tags
}

output "rotation_rules" {
  description = "Rotation rules if rotation is enabled."
  value       = data.aws_secretsmanager_secret.secret.rotation_rules
}

output "policy" {
  description = "Rotation rules if rotation is enabled."
  value       = data.aws_secretsmanager_secret.secret.policy
}

output "replica_arns" {
  description = "The ARNs of the replica secret. Keys are region names, values are ARNs."
  value = {
    for replica in var.replica_regions :
    replica.region => "arn:${data.aws_arn.secret.partition}:${data.aws_arn.secret.service}:${replica.region}:${data.aws_arn.secret.account}:${data.aws_arn.secret.resource}"
  }
}

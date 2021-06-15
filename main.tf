locals {
  converted_replica_regions = var.replica_regions != null ? [
    for replica in var.replica_regions :
    {
      for k, v in
      {
        KmsKeyId = replica.kms_key_id
        Region   = replica.region
      } :
      k => v
      if v != null
    }
  ] : null

  properties = {
    Description    = var.description
    KmsKeyId       = var.kms_key_id
    Name           = var.name
    ReplicaRegions = local.converted_replica_regions
    Tags           = var.tags
  }
}

// Create a random ID to give the stack a unique name
resource "random_id" "stack_id" {
  byte_length = 8
}

resource "aws_cloudformation_stack" "secret" {
  name = "replicated-secret-${upper(random_id.stack_id.hex)}"

  template_body = jsonencode({
    Resources = {
      secret = {
        Type = "AWS::SecretsManager::Secret"
        Properties = {
          for k, v in local.properties :
          k => v
          if v != null
        }
      }
    }
    Outputs = {
      arn = {
        Description = "The ARN of the created secret."
        Value       = { Ref = "secret" }
      }
    }
  })
}

data "aws_secretsmanager_secret" "secret" {
  arn = aws_cloudformation_stack.secret.outputs.arn
}

data "aws_arn" "secret" {
  arn = aws_cloudformation_stack.secret.outputs.arn
}

data "aws_region" "current" {}

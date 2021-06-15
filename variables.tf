variable "name" {
  description = "Specifies the friendly name of the new secret. The secret name can consist of uppercase letters, lowercase letters, digits, and any of the following characters: `/_+=.@-`. Conflicts with `name_prefix`."
  type        = string
  default     = null
}

variable "description" {
  description = "A description of the secret."
  type        = string
  default     = null
}

variable "kms_key_id" {
  description = "Specifies the ARN or Id of the AWS KMS customer master key (CMK) to be used to encrypt the secret values in the versions stored in this secret. If you don't specify this value, then Secrets Manager defaults to using the AWS account's default CMK (the one named `aws/secretsmanager`). If the default KMS CMK with that name doesn't yet exist, then AWS Secrets Manager creates it for you automatically the first time."
  type        = string
  default     = null
}

variable "policy" {
  description = "A valid JSON document representing a resource policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
  type        = string
  default     = null
}

variable "recovery_window_in_days" {
  description = "Specifies the number of days that AWS Secrets Manager waits before it can delete the secret. This value can be `0` to force deletion without recovery or range from `7` to `30` days. The default value is `30`."
  type        = number
  default     = null
}

variable "tags" {
  description = "Specifies a key-value map of user-defined tags that are attached to the secret. If configured with a provider `default_tags` configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  type        = map(string)
  default     = null
}

variable "replica_regions" {
  description = "A list of regions to replicate the secret to. Each element in the list must be a map with `kms_key_id` and `region` keys."
  type = list(object({
    kms_key_id = string
    region     = string
  }))
  default = null
}

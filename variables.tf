variable "account" {
  description = "account creds"
  type        = string
  default     = null
}
variable "project" {
  description = "(Required) Name of the project for deployment"
  type        = string
  default     = null
}

variable "region" {
  description = "(Required) Name of region for deployment"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = <<DESCRIPTION
    (Optional) Prefix added to all resource names. This should be unique if
    deploying multiple clusters into the same project. If no value is provided
    a random prefix is used. An empty value results in no prefix at all.
DESCRIPTION

  type    = string
  default = null
}

variable "zone" {
  description = <<DESCRIPTION
    (Optional) Zone for deployment. If no value is provided a random zone in
    the specified region is used.
DESCRIPTION

  default = null
}

terraform {
  required_version = "~> 0.11.0"

  backend "s3" {
    acl            = "private"
    bucket         = "tf-state-analytical-platform-landing"
    encrypt        = true
    key            = "iam.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "tf-state-lock"
    kms_key_id     = "arn:aws:kms:eu-west-1:335823981503:key/925a5b6c-7df1-49a0-a3cc-471e8524637d"
  }
}

provider "aws" {
  region  = "eu-west-1"
  version = "~> 2.6"

  assume_role {
    role_arn = "arn:aws:iam::${var.landing_account_id}:role/${var.landing_iam_role}"
  }
}

variable "landing_account_id" {
  description = "ID of account containing IAM users"
}

variable "ap_accounts" {
  type        = "map"
  description = "IDs of accounts to assume role into"
}

## MVision account

variable "mvision_account_id" {
  description = "ID of account containing mcafee mvision"
}

## Restricted Admin

variable "restricted_admin_name" {
  default = "restricted-admin"
}

## Read Only

variable "read_only_name" {
  default = "read-only"
}

## Read Data Only

variable "read_data_only_name" {
  default = "read-s3-only"
}

## Data Admin

variable "data_admin_name" {
  default = "data-admin-in"
}

variable "terraform_infrastructure_name" {
  default = "terraform-infrastructure"
}

variable "mcafee_mvision_trial_role" {
  default = "mcafee-mvision-trial-role"
}

variable "terraform_aws_security_name" {
  default = "terraform-aws-security"
}

variable "landing_iam_role" {
  default = "landing-iam-role"
}

## Suspended Users

variable "suspended_users_name" {
  default = "suspended_users"
}

## MVision external ID

variable "mvision_external_id" {
  default = "9886771"
}

## Audit Security role name

variable "audit_security_name" {
  default = "AuditAdminRole"
}

variable "security_account_id" {
  description = "AWS Security account ID"
}

## Calum Test

variable "calum_test_name" {
  default = "calum_test"
}

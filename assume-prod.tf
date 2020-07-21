locals {
  prod = "prod"
}

##### Restricted Admin #####
## Restricted Admin Group

module "assume_restricted_admin_in_prod" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/assume"

  assumed_role_name = "${var.restricted_admin_name}-${local.prod}"

  assume_role_in_account_id = [
    var.ap_accounts["prod"],
  ]

  landing_account_id = var.landing_account_id
  group_name         = "${var.restricted_admin_name}-${local.prod}"

  users = [
    aws_iam_user.aldo.name,
    aws_iam_user.david.name,
    aws_iam_user.andrew.name,
    aws_iam_user.nicholas.name,
    aws_iam_user.toms.name,
    aws_iam_user.danw.name,
  ]
}

## Create restricted admin role in prod account
module "add_restricted_admin_role_in_prod" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/role"

  providers = {
    aws = aws.prod
  }

  role_name          = "${var.restricted_admin_name}-${local.prod}"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.restricted_admin.json
}

##### READ ONLY #####
## Read Only Group

module "assume_read_only_in_prod" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/assume"

  assumed_role_name = "${var.read_only_name}-${local.prod}"

  assume_role_in_account_id = [
    var.ap_accounts["prod"],
  ]

  landing_account_id = var.landing_account_id
  group_name         = "${var.read_only_name}-${local.prod}"

  users = [
    aws_iam_user.aldo.name,
    aws_iam_user.david.name,
    aws_iam_user.andrew.name,
    aws_iam_user.nicholas.name,
    aws_iam_user.toms.name,
    aws_iam_user.danw.name,
  ]
}

## Create read only role in data account
module "add_read_only_role_in_prod" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/role"

  providers = {
    aws = aws.prod
  }

  role_name          = "${var.read_only_name}-${local.prod}"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.read_only.json
}

## Create audit security role in prod account
module "add_audit_security_role_in_prod" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/role"

  providers = {
    aws = aws.prod
  }

  role_name          = var.audit_security_name
  landing_account_id = var.security_account_id
  role_policy_arn    = "arn:aws:iam::aws:policy/SecurityAudit"
}

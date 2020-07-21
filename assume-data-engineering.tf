locals {
  data-engineering = "data-engineering"
}

##### Restricted Admin #####

## Create restricted admin group in data engineering account
module "assume_restricted_admin_in_data_engineering" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/assume"

  assumed_role_name = "${var.restricted_admin_name}-${local.data-engineering}"

  assume_role_in_account_id = [
    var.data_engineering_account_id,
  ]

  landing_account_id = var.landing_account_id
  group_name         = "${var.restricted_admin_name}-${local.data-engineering}"

  users = [
    aws_iam_user.alec.name,
    aws_iam_user.darius.name,
    aws_iam_user.calum.name,
    aws_iam_user.davidf.name,
    aws_iam_user.jacob.name,
  ]
}

## Create restricted admin role in data engineering account
module "add_restricted_admin_role_in_data_engineering" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/role"

  providers = {
    aws = aws.data-engineering
  }

  role_name          = "${var.restricted_admin_name}-${local.data-engineering}"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.restricted_admin.json
}

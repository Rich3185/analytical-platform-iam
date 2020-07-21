locals {
  data = "data"
}

##### Restricted Admin #####
## Restricted Admin Group

module "assume_restricted_admin_in_data" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/assume"

  assumed_role_name = "${var.restricted_admin_name}-${local.data}"

  assume_role_in_account_id = [
    var.ap_accounts["data"],
  ]

  landing_account_id = var.landing_account_id
  group_name         = "${var.restricted_admin_name}-${local.data}"

  users = [
    aws_iam_user.aldo.name,
    aws_iam_user.david.name,
    aws_iam_user.andrew.name,
    aws_iam_user.nicholas.name,
    aws_iam_user.toms.name,
    aws_iam_user.danw.name,
  ]
}

## Create restricted admin role in data account
module "add_restricted_admin_role_in_data" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/role"

  providers = {
    aws = aws.data
  }

  role_name          = "${var.restricted_admin_name}-${local.data}"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.restricted_admin.json
}

##### READ ONLY #####
## Read Only Group

module "assume_read_only_in_data" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/assume"

  assumed_role_name = "${var.read_only_name}-${local.data}"

  assume_role_in_account_id = [
    var.ap_accounts["data"],
  ]

  landing_account_id = var.landing_account_id
  group_name         = "${var.read_only_name}-${local.data}"

  users = []
}

## Create read only role in data account
module "add_read_only_role_in_data" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/role"

  providers = {
    aws = aws.data
  }

  role_name          = "${var.read_only_name}-${local.data}"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.read_only.json
}

##### READ S3 ONLY #####
## Read S3 Only Group

module "assume_read_s3_only_in_data" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/assume"

  assumed_role_name = "${var.read_data_only_name}-${local.data}-acc"

  assume_role_in_account_id = [
    var.ap_accounts["data"],
  ]

  landing_account_id = var.landing_account_id
  group_name         = "${var.read_data_only_name}-${local.data}-acc"

  users = [
    aws_iam_user.calum.name,
    aws_iam_user.sam.name,
    aws_iam_user.andrew.name,
    aws_iam_user.toms.name,
    aws_iam_user.danw.name,
  ]
}

## Create read s3 only role in data account
module "add_read_data_only_role_in_data" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/role"

  providers = {
    aws = aws.data
  }

  role_name          = "${var.read_data_only_name}-${local.data}-acc"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.read_data_only.json
}

##### DATA ADMIN #####
## Data ADMIN Group

module "assume_data_admin_in_data" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/assume"

  assumed_role_name = "${var.data_admin_name}-${local.data}-acc"

  assume_role_in_account_id = [
    var.ap_accounts["data"],
  ]

  landing_account_id = var.landing_account_id
  group_name         = "${var.data_admin_name}-${local.data}-acc"

  users = [
    aws_iam_user.aldo.name,
    aws_iam_user.karik.name,
    aws_iam_user.george.name,
    aws_iam_user.david.name,
    aws_iam_user.robin.name,
    aws_iam_user.andrew.name,
    aws_iam_user.nicholas.name,
    aws_iam_user.toms.name,
    aws_iam_user.danw.name,
  ]
}

## Create read data only role in data account
module "add_data_admin_role_in_data" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/role"

  providers = {
    aws = aws.data
  }

  role_name          = "${var.data_admin_name}-${local.data}-acc"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.data_admin.json
}

## Create audit security role in data account
module "add_audit_security_role_in_data" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/role"

  providers = {
    aws = aws.data
  }

  role_name          = var.audit_security_name
  landing_account_id = var.security_account_id
  role_policy_arn    = "arn:aws:iam::aws:policy/SecurityAudit"
}

##### DATA Engineer #####
## Data Engineers Group

module "add_data_engineers_group" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/assume"

  assumed_role_name = var.data_engineers_name

  assume_role_in_account_id = [
    var.ap_accounts["data"],
  ]

  landing_account_id = var.landing_account_id
  group_name         = var.data_engineers_name

  users = [
    aws_iam_user.karik.name,
    aws_iam_user.george.name,
    aws_iam_user.adam.name,
    aws_iam_user.calum.name,
    aws_iam_user.anthony.name,
    aws_iam_user.robin.name,
    aws_iam_user.sam.name,
  ]
}

## Create Data Engineers Role in Data Account

module "add_data_engineers_role_in_data_account" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/role"

  providers = {
    aws = aws.data
  }

  role_name          = var.data_engineers_name
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.data_engineer.json
}

#### HMCTS S3 Data Admin
module "add_hmcts_data_engineers_group" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/assume"

  assumed_role_name = var.hmcts_data_engineers_name

  assume_role_in_account_id = [
    var.ap_accounts["data"],
  ]

  landing_account_id = var.landing_account_id
  group_name         = var.hmcts_data_engineers_name

  users = [
    aws_iam_user.karik.name,
    aws_iam_user.george.name,
    aws_iam_user.adam.name,
    aws_iam_user.calum.name,
    aws_iam_user.anthony.name,
    aws_iam_user.robin.name,
    aws_iam_user.sam.name,
  ]
}

## Create HMCTS Data Engineers Role in Data Account
module "add_hmcts_data_engineers_role_in_data_account" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/role"

  providers = {
    aws = aws.data
  }

  role_name          = var.hmcts_data_engineers_name
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.hmcts_data_engineer.json
}

#### PROBATION S3 Data Admin
module "add_probation_data_engineers_group" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/assume"

  assumed_role_name = var.probation_data_engineers_name

  assume_role_in_account_id = [
    var.ap_accounts["data"],
  ]

  landing_account_id = var.landing_account_id
  group_name         = var.probation_data_engineers_name

  users = [
    aws_iam_user.karik.name,
    aws_iam_user.george.name,
    aws_iam_user.adam.name,
    aws_iam_user.calum.name,
    aws_iam_user.anthony.name,
    aws_iam_user.robin.name,
    aws_iam_user.sam.name,
  ]
}

## Create PROBATION Data Engineers Role in Data Account
module "add_probation_data_engineers_role_in_data_account" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/role"

  providers = {
    aws = aws.data
  }

  role_name          = var.probation_data_engineers_name
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.probation_data_engineer.json
}

#### PRISON S3 Data Admin
module "add_prison_data_engineers_group" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/assume"

  assumed_role_name = var.prison_data_engineers_name

  assume_role_in_account_id = [
    var.ap_accounts["data"],
  ]

  landing_account_id = var.landing_account_id
  group_name         = var.prison_data_engineers_name

  users = [
    aws_iam_user.karik.name,
    aws_iam_user.george.name,
    aws_iam_user.adam.name,
    aws_iam_user.calum.name,
    aws_iam_user.anthony.name,
    aws_iam_user.robin.name,
    aws_iam_user.sam.name,
  ]
}

## Create PRISON Data Engineers Role in Data Account
module "add_prison_data_engineers_role_in_data_account" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/role"

  providers = {
    aws = aws.data
  }

  role_name          = var.prison_data_engineers_name
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.prison_data_engineer.json
}

#### CORPORATE S3 Data Admin
module "add_corporate_data_engineers_group" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/assume"

  assumed_role_name = var.corporate_data_engineers_name

  assume_role_in_account_id = [
    var.ap_accounts["data"],
  ]

  landing_account_id = var.landing_account_id
  group_name         = var.corporate_data_engineers_name

  users = [
    aws_iam_user.karik.name,
    aws_iam_user.george.name,
    aws_iam_user.adam.name,
    aws_iam_user.calum.name,
    aws_iam_user.anthony.name,
    aws_iam_user.robin.name,
    aws_iam_user.sam.name,
  ]
}

## Create CORPORATE Data Engineers Role in Data Account
module "add_corporate_data_engineers_role_in_data_account" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/role"

  providers = {
    aws = aws.data
  }

  role_name          = var.corporate_data_engineers_name
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.corporate_data_engineer.json
}

#### Billing  ####
## Create Billing Viewer Role in Data Account

module "add_billing_viewer_role_in_data_account" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/role"

  providers = {
    aws = aws.data
  }

  role_name          = var.billing_viewer_name
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.billing_viewer.json
}

## Billing Viewer Group

module "add_billing_viewer_group" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/assume"

  assumed_role_name = var.billing_viewer_name

  assume_role_in_account_id = [
    var.ap_accounts["data"],
  ]

  landing_account_id = var.landing_account_id
  group_name         = var.billing_viewer_name

  users = [
    aws_iam_user.karik.name,
    aws_iam_user.calum.name,
    aws_iam_user.robin.name,
    aws_iam_user.sam.name,
    aws_iam_user.david.name,
    aws_iam_user.aldo.name,
    aws_iam_user.andrew.name,
    aws_iam_user.nicholas.name,
    aws_iam_user.toms.name,
    aws_iam_user.danw.name,
  ]
}

##### Quicksight Admin #####
## Quicksight Admin Group

module "assume_quicksight_admin_in_data" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/assume"

  assumed_role_name = "${var.quicksight_admin_name}-${local.data}"

  assume_role_in_account_id = [
    var.ap_accounts["data"],
  ]

  landing_account_id = var.landing_account_id
  group_name         = "${var.quicksight_admin_name}-${local.data}"

  users = [
    aws_iam_user.gareth.name,
  ]
}

## Create quicksight admin role in data account
module "add_quicksight_admin_role_in_data" {
  # TF-UPGRADE-TODO: In Terraform v0.11 and earlier, it was possible to
  # reference a relative module source without a preceding ./, but it is no
  # longer supported in Terraform v0.12.
  #
  # If the below module source is indeed a relative local path, add ./ to the
  # start of the source string. If that is not the case, then leave it as-is
  # and remove this TODO comment.
  source = "./modules/role"

  providers = {
    aws = aws.data
  }

  role_name          = "${var.quicksight_admin_name}-${local.data}"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.quicksight_admin.json
}

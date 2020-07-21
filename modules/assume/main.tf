locals {
  # The role(s) in the remote AWS accounts that you want to assume into
  roles = join(
    ",\n",
    formatlist(
      "arn:aws:iam::%s:role/%s",
      var.assume_role_in_account_id,
      var.assumed_role_name,
    ),
  )
}

# Policy for AssumeRole
data "aws_iam_policy_document" "policy" {
  statement {
    effect  = var.group_effect
    actions = [var.group_effect == "Allow" ? "sts:AssumeRole" : "*"]
    # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
    # force an interpolation expression to be interpreted as a list by wrapping it
    # in an extra set of list brackets. That form was supported for compatibility in
    # v0.11, but is no longer supported in Terraform v0.12.
    #
    # If the expression in the following list itself returns a list, remove the
    # brackets to avoid interpretation as a list of lists. If the expression
    # returns a single list item then leave it as-is and remove this TODO comment.
    resources = [var.group_effect == "Allow" ? local.roles : "*"]
  }
}

## IAM Group
resource "aws_iam_group" "group" {
  name = var.group_name
}

## Add users to the group
resource "aws_iam_group_membership" "group_membership" {
  group = aws_iam_group.group.name
  name  = "group-membership"
  users = var.users
}

## Policies
resource "aws_iam_policy" "manage" {
  policy = data.aws_iam_policy_document.manage_own_creds.json
  name   = "manage-own-creds-${var.group_name}"
}

resource "aws_iam_policy" "assume" {
  policy = data.aws_iam_policy_document.policy.json
  name   = "assume-role-${var.group_name}"
}

## Attach policies to the group
resource "aws_iam_policy_attachment" "manage" {
  name       = aws_iam_group.group.name
  policy_arn = aws_iam_policy.manage.arn
  groups     = [aws_iam_group.group.name]
}

resource "aws_iam_policy_attachment" "assume" {
  name       = aws_iam_group.group.name
  policy_arn = aws_iam_policy.assume.arn
  groups     = [aws_iam_group.group.name]
}

data "aws_iam_policy_document" "user_guidance_maintainer" {
  statement {
    sid    = "AllowAccessToUserGuidanceBuckets"
    effect = "Allow"

    actions = [
      "s3:*"
    ]

    resources = [
      "arn:aws:s3:::user-guidance.analytical-platform.services.justice.gov.uk",
      "arn:aws:s3:::user-guidance.services.alpha.mojanalytics.xyz-cloudfront-logs",
    ]
  }

  statement {
    sid    = "AllowListIAMUsers"
    effect = "Allow"

    actions = [
      "iam:ListUsers",
      "iam:ListPolicies",
    ]

    resource = [
      "*"
    ]
  }

  statement {
    sid    = "AllowCircleCIUserActions"
    effect = "Allow"

    actions = [
      "iam:AttachUserPolicy",
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:DeleteUserPolicy",
      "iam:DeleteUserPermissionsBoundary",
      "iam:DetachUserPolicy",
      "iam:GetAccessKeyLastUsed",
      "iam:GetUser",
      "iam:GetUserPolicy",
      "iam:ListAccessKeys",
      "iam:ListAttachedUserPolicies",
      "iam:ListUserPolicies",
      "iam:ListUserTags",
      "iam:PutUserPolicy",
      "iam:PutUserPermissionsBoundary",
      "iam:TagUser",
      "iam:UntagUser",
      "iam:UpdateAccessKey",
      "iam:UpdateUser",
    ]

    resources = [
      "arn:aws:iam::${var.ap_accounts["data"]}:user/circleci",
    ]
  }

  statement {
    sid    = "AllowFullCloudFrontConsoleAccess"
    effect = "Allow"
    actions = [
      "acm:ListCertificates",
      "cloudfront:*",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:GetMetricStatistics",
      "elasticloadbalancing:DescribeLoadBalancers",
      "iam:ListServerCertificates",
      "sns:ListSubscriptionsByTopic",
      "sns:ListTopics",
      "waf:GetWebACL",
      "waf:ListWebACLs"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:PutBucketPolicy"
    ]
    resources = [
      "arn:aws:s3:::*"
    ]
  }

  statement {
    sid    = "AllowFullRoute53ConsoleAccess"
    effect = "Allow"
    actions = [
      "route53:*",
      "route53domains:*",
      "cloudfront:ListDistributions",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticbeanstalk:DescribeEnvironments",
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:GetBucketWebsite",
      "ec2:DescribeRegions",
      "ec2:DescribeVpcs",
      "ec2:CreateNetworkInterface",
      "ec2:CreateNetworkInterfacePermission",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:ModifyNetworkInterfaceAttribute",
      "sns:ListTopics",
      "sns:ListSubscriptionsByTopic",
      "sns:CreateTopic",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DeleteAlarms",
      "cloudwatch:GetMetricStatistics"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "apigateway:GET"
    ]
    resources = [
      "arn:aws:apigateway:*::/domainnames"
    ]
  }

  statement {
    sid    = "AllowFullACMConsoleAccess"
    effect = "Allow"
    actions = [
      "acm:*"
    ]
    resources = [
      "*"
    ]
  }
}

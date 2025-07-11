module "lambda_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.30.0"

  trusted_role_services = [
    "lambda.amazonaws.com"
  ]

  create_role       = true
  role_name         = "shortener-lambda-role"
  role_requires_mfa = false
  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess",
    module.lambda_policy.arn,
  ]
}

module "lambda_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 5.30.0"

  name = "shortener-lambda-policy"

  policy = data.aws_iam_policy_document.lambda_policy.json
}

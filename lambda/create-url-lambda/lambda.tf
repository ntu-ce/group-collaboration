module "create_url_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 7.7.0"

  function_name = "shortener-url-create"
  description   = "Lambda function to create URL"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"
  publish       = true
  lambda_role   = module.lambda_role.iam_role_arn
  create_role   = false
  tracing_mode  = "Active"

  create_package = true
  source_path    = "./lambda/create-url-lambda/lambda_function.py"

  allowed_triggers = {
    AllowExecutionFromAPIGateway = {
      service = "apigateway"
    }
  }

  environment_variables = {
    APP_URL    = "https://shortener.sctp-sandbox.com/"
    MAX_CHAR   = "16"
    MIN_CHAR   = "12"
    REGION_AWS = data.aws_region.current.region
    DB_NAME    = aws_dynamodb_table.shortener_table.name
  }
}


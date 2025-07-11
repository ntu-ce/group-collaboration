module "retrieve_url_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 7.7.0"

  function_name = "shortener-url-retrieve"
  description   = "Lambda function to retrieve URL"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"
  publish       = true
  create_role   = false
  lambda_role   = module.lambda_role.iam_role_arn
  tracing_mode  = "Active"


  create_package = true
  source_path    = "./lambda/retrieve-url-lambda/lambda_function.py"

  allowed_triggers = {
    AllowExecutionFromAPIGateway = {
      service = "apigateway"
    }
  }

  environment_variables = {
    REGION_AWS = data.aws_region.current.region
    DB_NAME    = aws_dynamodb_table.shortener_table.name
  }
}

provider "aws" {
  region = "us-east-1"
  profile = var.profile
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam-for-lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda-zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/updateViewcount.py"
  output_path = "${path.module}/lambda/updateViewcount.zip"
}

resource "aws_lambda_function" "update-viewcount-lambda" {
  filename      = data.archive_file.lambda-zip.output_path
  function_name = "addViewcount"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "updateViewcount.lambda_handler"

  source_code_hash = data.archive_file.lambda-zip.output_base64sha256

  runtime = "python3.12"
}

data "aws_iam_policy_document" "dynamodb_access" {
  statement {
    effect = "Allow"

    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:BatchGetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:DeleteItem"
    ]

    resources = [var.db_arn]
  }
}

resource "aws_iam_role_policy" "lambda_dynamodb_policy" {
  name   = "lambda-dynamodb-access"
  role   = aws_iam_role.iam_for_lambda.id
  policy = data.aws_iam_policy_document.dynamodb_access.json
}

# API GATEWAY 

# resource "aws_api_gateway_rest_api" "updateViewcountapi" {
#   body = jsonencode({
#     openapi = "3.0.1"
#     info = {
#       title   = "example"
#       version = "1.0"
#     }
#     paths = {
#       "/" = {
#         get = {
#           x-amazon-apigateway-integration = {
#             httpMethod           = "GET"
#             type                 = "AWS"
#             uri                  = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/${aws_lambda_function.update-viewcount-lambda.arn}/invocations"
#           }
#         }
#       }
#     }
#   })

#   name = "updateViewcountapi"

#   endpoint_configuration {
#     types = ["REGIONAL"]
#   }
# }

# resource "aws_lambda_permission" "updateViewcountlambdaperm" {
#   statement_id  = "AllowAPIGatewayInvoke"
#   action        = "lambda:InvokeFunction"
#   function_name = "addViewcount"
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "${aws_api_gateway_rest_api.updateViewcountapi.execution_arn}/*/*/*"
# }

# resource "aws_api_gateway_stage" "updateViewcountstage" {
#   deployment_id = aws_api_gateway_deployment.updateViewcountdeployment.id
#   rest_api_id   = aws_api_gateway_rest_api.updateViewcountapi.id
#   stage_name    = "prod"
# }

# resource "aws_api_gateway_deployment" "updateViewcountdeployment" {
#   rest_api_id = aws_api_gateway_rest_api.updateViewcountapi.id
# }

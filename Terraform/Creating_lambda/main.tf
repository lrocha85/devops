# Set the region
provider "aws" {
  region = "us-east-1"
}

# Creating the lambda
resource "aws_lambda_function" "function_lambda" {
  depends_on = [
    null_resource.zip
  ]
  filename      = var.FILENAME
  function_name = var.LAMBDA_NAME
  role          = aws_iam_role.lambda.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"

  layers        = [
    "arn",
    ]
}

# Crating the trigger, in this case, S3 trigger
resource "aws_s3_bucket_notification" "name" {
    depends_on = [
    aws_lambda_function.function_lambda
  ]
  bucket = "bucket_name"
  lambda_function {
    lambda_function_arn = aws_lambda_function.function_lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "files/"
  }
}
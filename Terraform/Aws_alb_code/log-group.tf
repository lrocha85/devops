# Creating log group for this alb
resource "aws_cloudwatch_log_group" "name" {
  name              = "name"
  retention_in_days = 30
}
# Creating log group
resource "aws_cloudwatch_log_group" "resource-name" {
  name              = "log-group-name"
  retention_in_days = 1
}
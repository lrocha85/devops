resource "aws_cloudwatch_log_group" "cluster" {
  name = var.name
  retention_in_days = 30  
}

resource "aws_ecs_cluster" "dev" {
  name = var.name
  
  setting {
    name  = "containerInsights"
    value = "enabled"
  } 
}

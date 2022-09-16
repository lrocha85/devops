# Creating the cluster
resource "aws_ecs_cluster" "resource-name" {
  name = "cluster-name"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
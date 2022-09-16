# Creating a task definition resource, this resource set details for service and the container definitions set details for container
resource "aws_ecs_task_definition" "resource-name" {
  family                   = "resource-name"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = var.ROLE
  task_role_arn 	         = var.ROLE
  container_definitions = jsonencode([
    {
      name             = "container_name"
      image            = var.IMAGEM
      essential        = true
      cpu              = 1024
      memory           = 2048
      executionRoleArn = var.ROLE

      logConfiguration = {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${aws_cloudwatch_log_group.app-name.name}",
            "awslogs-region": "us-east-1",
            "awslogs-stream-prefix": "ecs"
          }
        }

      portMappings = [
        {
          containerPort = var.CONTAINER_PORT
          hostPort      = var.HOST_PORT
        }
      ]
    }
  ])
}

# Creating service
resource "aws_ecs_service" "resource.name" {
  name                 = "service-name"
  cluster              = "cluster-name"
  task_definition      = aws_ecs_task_definition.task_definition.name.arn
  launch_type          = "FARGATE"
  desired_count        = 1
  force_new_deployment = true
  enable_execute_command = true

  network_configuration {
    subnets         = ["subnet-name"]
    security_groups = ["sg-name"]
    assign_public_ip = true

  }
}



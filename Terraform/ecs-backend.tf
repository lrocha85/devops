# Creating a task definition resource, this resource set details for service and the container definitions set details for container
resource "aws_ecs_task_definition" "cluster-task-backend" {
  family                   = "---"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = aws_iam_role.cluster_role.arn
  task_role_arn 	         = aws_iam_role.cluster_role.arn
  container_definitions = jsonencode([
    {
      name             = "--"
      image            = var.IMAGEM_BACKEND
      essential        = true
      cpu              = 512
      memory           = 1024
      containerPort    = "80:80"
      executionRoleArn = aws_iam_role.cluster_role.arn    

      logConfiguration = {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${aws_cloudwatch_log_group.plataforma-web-backend.name}",
            "awslogs-region": "us-east-1",
            "awslogs-stream-prefix": "ecs"
          }
        }

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
 
    }
  ])
}

# Creating service
resource "aws_ecs_service" "plataforma-web-backend-sv" {
  name                 = "---"
  cluster              = aws_ecs_cluster.dev-picsel.arn
  task_definition      = aws_ecs_task_definition.cluster-task-backend.arn
  launch_type          = "FARGATE"
  desired_count        = 1
  force_new_deployment = true
  enable_execute_command = true

  network_configuration {
    subnets         = ["---"]
    assign_public_ip = true
    security_groups = ["---"]
  }
  load_balancer {
    target_group_arn = aws_alb_target_group.target_backend.arn
    container_name   = "---"
    container_port   = 80
  }
}
resource "aws_alb" "ecs-dev" {
  name            = "NAME"
  security_groups = ["----"]
  subnets         = ["-----"]
}

# Creating a target group resource to use with loadbalance
resource "aws_alb_target_group" "target" {
  name        = "-----"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "----"
    
    health_check {
    path              = "/"
    interval          = 60
    port              = 80
    protocol          = "HTTP"
    timeout           = 3
    healthy_threshold = 3
    unhealthy_threshold = 3
    matcher = "200-404"
  }
}

resource "aws_alb_target_group" "target_backend" {
  name        = "----"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "---"
    
    health_check {
    path              = "/"
    interval          = 60
    port              = 80
    protocol          = "HTTP"
    timeout           = 3
    healthy_threshold = 3
    unhealthy_threshold = 3
    matcher = "200-404"
  }
}

resource "aws_alb_target_group" "target_laravel" {
  name        = "---"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "---"
    
    health_check {
    path              = "/"
    interval          = 60
    port              = 80
    protocol          = "HTTP"
    timeout           = 3
    healthy_threshold = 3
    unhealthy_threshold = 3
    matcher = "200-404"
  }
}

resource "aws_alb_target_group" "target_mapa" {
  name        = "---"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "---"
    
    health_check {
    path              = "/api/"
    interval          = 60
    port              = 80
    protocol          = "HTTP"
    timeout           = 3
    healthy_threshold = 3
    unhealthy_threshold = 3
    matcher = "200-404"
  }
}

resource "aws_alb_target_group" "target_ondemand" {
  name        = "---"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "---"
    
    health_check {
    path              = "/"
    interval          = 60
    port              = 80
    protocol          = "HTTP"
    timeout           = 3
    healthy_threshold = 3
    unhealthy_threshold = 3
    matcher = "200-404"
  }
}

# Creating a listener necessary for loadbalance
resource "aws_alb_listener" "ecs-cluster-listener" {
  load_balancer_arn = aws_alb.ecs-dev.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = "---"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target.arn
  }
}

resource "aws_lb_listener_certificate" "additional_cert_1" {
  listener_arn    = aws_alb_listener.ecs-cluster-listener.arn
  certificate_arn = "---"
}

resource "aws_lb_listener_certificate" "additional_cert_2" {
  listener_arn    = aws_alb_listener.ecs-cluster-listener.arn
  certificate_arn = "---"
}

resource "aws_alb_listener" "ecs-cluster-listener-80" {
  load_balancer_arn = aws_alb.ecs-dev.arn
  port              = 80
  protocol          = "HTTP"

default_action {
    type             = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "ecs-cluster-listener-backend" {
  load_balancer_arn = aws_alb.ecs-dev.arn
  port              = 9000
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = "---"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_backend.arn
}
}


resource "aws_alb_listener" "ecs-cluster-listener-laravel" {
  load_balancer_arn = aws_alb.ecs-dev.arn
  port              = 9001
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = "----"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_laravel.arn
}
}

resource "aws_alb_listener" "ecs-cluster-listener-mapa" {
  load_balancer_arn = aws_alb.ecs-dev.arn
  port              = 9002
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = "---"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_mapa.arn
}
}

resource "aws_lb_listener_rule" "rule" {
  listener_arn = aws_alb_listener.ecs-cluster-listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target.arn
  }

  condition {
    host_header {
      values = ["-----"]
    }
  }
}

resource "aws_lb_listener_rule" "rule-backend" {
  listener_arn = aws_alb_listener.ecs-cluster-listener.arn
  priority     = 2

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_backend.arn
  }

  condition {
    host_header {
      values = ["-----"]
    }
  }
}

resource "aws_lb_listener_rule" "rule-laravel" {
  listener_arn = aws_alb_listener.ecs-cluster-listener-backend.arn
  priority     = 3

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_laravel.arn
  }

  condition {
    path_pattern {
      values = ["----"]
    }
  }
}

resource "aws_lb_listener_rule" "rule-mapa" {
  listener_arn = aws_alb_listener.ecs-cluster-listener.arn
  priority     = 4

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_mapa.arn
  }

  condition {
    host_header {
      values = ["----"]
    }
  }
}

resource "aws_lb_listener_rule" "rule-ondemand" {
  listener_arn = aws_alb_listener.ecs-cluster-listener.arn
  priority     = 5

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_ondemand.arn
  }

  condition {
    path_pattern {
      values = ["-----"]
    }
  }
}
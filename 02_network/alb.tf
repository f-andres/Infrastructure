//# alb.tf
//
resource "aws_alb" "ecs_lb" {
  name            = "ecs-lb"
  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.lb_sg.id]
}

resource "aws_alb_target_group" "app" {
  name        = "cb-target-group"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpccluster.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}

# resource "aws_alb_target_group" "app-2" {
#   name        = "cb-target-group-2"
#   port        = "443"
#   protocol    = "HTTPS"
#   vpc_id      = aws_vpc.vpccluster.id
#   target_type = "ip"

#   health_check {
#     healthy_threshold   = "3"
#     interval            = "30"
#     protocol            = "HTTP"
#     matcher             = "200"
#     timeout             = "3"
#     path                = "/login"
#     unhealthy_threshold = "2"
#   }
# }


# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.ecs_lb.id
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}

resource "aws_alb_listener" "front_end_ssl" {
  load_balancer_arn = aws_alb.ecs_lb.id
  port              = "443"
  protocol          = "HTTPS"
    certificate_arn   = data.terraform_remote_state.usuarios.outputs.test_cert 
   
  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}
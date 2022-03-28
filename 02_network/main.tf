
//resource "aws_vpc" "vpccluster" {
//  cidr_block       = "10.0.0.0/16"
//  instance_tenancy = "default"
//
//  tags = {
//    Name = var.vpc_name
//  }
//}
//
//
//# Internet gateway for the public subnet
//resource "aws_internet_gateway" "ecsclusterIG" {
//  vpc_id = aws_vpc.vpccluster.id
////  tags {
////    Name = "ecsclusterIG"
////  }
//}
//
//resource "aws_subnet" "main" {
//  vpc_id            = aws_vpc.vpccluster.id
//  cidr_block        = "10.0.1.0/24"
//  availability_zone = "us-east-1a"
//
//  tags = {
//    Name = "Main"
//  }
//}
//
//resource "aws_subnet" "secondary" {
//  vpc_id            = aws_vpc.vpccluster.id
//  cidr_block        = "10.0.2.0/24"
//  availability_zone = "us-east-1b"
//  tags = {
//  Name = "secondary" }
//}
//
//# Routing table for public subnet
//resource "aws_route_table" "ecscluster-RT" {
//  vpc_id = aws_vpc.vpccluster.id
//  route {
//    cidr_block = "0.0.0.0/0"
//    gateway_id = aws_internet_gateway.ecsclusterIG.id
//  }
//  //  tags {
//  //    Name = "vpccluster-RT"
//  //  }
//}
//
//# Associate the routing table to public subnet
//resource "aws_route_table_association" "ecscluster-RTAssn" {
//  subnet_id      = aws_subnet.main.id
//  route_table_id = aws_route_table.ecscluster-RT.id
//}
//
//resource "aws_route_table" "ecscluster-RT2" {
//  vpc_id = aws_vpc.vpccluster.id
//  route {
//    cidr_block = "0.0.0.0/0"
//    gateway_id = aws_internet_gateway.ecsclusterIG.id
//  }
//  //  tags {
//  //    Name = "vpccluster-RT"
//  //  }
//}
//
//resource "aws_route_table_association" "ecscluster-RTBssn" {
//  subnet_id      = aws_subnet.secondary.id
//  route_table_id = aws_route_table.ecscluster-RT2.id
//}
//# ECS Instance Security group
//
//resource "aws_security_group" "ecs_cluster_public_sg" {
//  name        = "ecs_cluster_public_sg"
//  description = "Test public access security group"
//  vpc_id      = aws_vpc.vpccluster.id
//
//  ingress {
//    from_port = 22
//    to_port   = 22
//    protocol  = "tcp"
//    cidr_blocks = [
//    "0.0.0.0/0"]
//  }
//
//  ingress {
//    from_port = 80
//    to_port   = 80
//    protocol  = "tcp"
//    cidr_blocks = [
//    "0.0.0.0/0"]
//  }
//
//  ingress {
//    from_port = 8080
//    to_port   = 8080
//    protocol  = "tcp"
//    cidr_blocks = [
//    "0.0.0.0/0"]
//  }
//
//
//  egress {
//    # allow all traffic to private SN
//    from_port = "0"
//    to_port   = "0"
//    protocol  = "-1"
//    cidr_blocks = [
//    "0.0.0.0/0"]
//  }
//}
//
////#################
////
////#load blancer
////
//resource "aws_alb" "ecs-load-balancer" {
//  name            = "ecs-load-balancer"
//  security_groups = ["${aws_security_group.ecs_cluster_public_sg.id}"]
//  subnets         = ["${aws_subnet.main.id}", "${aws_subnet.secondary.id}"]
//
//}
//
//resource "aws_alb_target_group" "ecs-target-group" {
//  name     = "ecs-target-group"
//  port     = "80"
//  protocol = "HTTP"
//  vpc_id   = aws_vpc.vpccluster.id
//
//  health_check {
//    healthy_threshold   = "5"
//    unhealthy_threshold = "2"
//    interval            = "30"
//    matcher             = "200"
//    path                = "/"
//    port                = "traffic-port"
//    protocol            = "HTTP"
//    timeout             = "5"
//  }
//
//}
//
//resource "aws_alb_listener" "alb-listener" {
//  load_balancer_arn = aws_alb.ecs-load-balancer.arn
//  port              = "80"
//  protocol          = "HTTP"
//
//  default_action {
//    target_group_arn = aws_alb_target_group.ecs-target-group.arn
//    type             = "forward"
//  }
//}
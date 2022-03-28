terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

//resource "aws_ecs_cluster" "cluster" {
//  name = var.cluster_name
//}
//
////resource "aws_ecs_task_definition" "web" {
////  "family": "dropinfun-spots-task",
////  "executionRoleArn": "arn:aws:iam::************:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS",
////  "taskRoleArn" : "here_you_can_define_arn_of_a_specific_iam_role"
////  "memory": "0.5GB",
////  "cpu": "256",
////  "networkMode": "awsvpc",
////  "requiresCompatibilities": [
////    "FARGATE"
////  ],
////  container_definitions = jsonencode([
////    {
////      name      = "nginx"
////      image     = data.terraform_remote_state.ecr.outputs.repo_arn
////      cpu       = 10
////      memory    = 512
////      essential = true
////      portMappings = [
////        {
////          containerPort = 80
////          hostPort      = 80
////        }
////      ]
////    },
////    {
////      name      = "nginx"
////      image     = "service-second"
////      cpu       = 10
////      memory    = 256
////      essential = true
////      portMappings = [
////        {
////          containerPort = 443
////          hostPort      = 443
////        }
////      ]
////    }
////  ])
////
////  volume {
////    name      = "service-storage"
////    host_path = "/ecs/service-storage"
////  }
////
////}
//resource "aws_ecs_service" "web" {
//  name            = "mweb"
//  cluster         = aws_ecs_cluster.cluster.id
//  task_definition = aws_ecs_task_definition.web.arn
//  desired_count   = 2
//  iam_role        = data.terraform_remote_state.usuarios.outputs.role_service_arn
//
//  load_balancer {
//    target_group_arn = data.terraform_remote_state.network.outputs.ecs-target-group_arn
//    container_port   = 80
//    container_name   = "nginx"
//  }
//}

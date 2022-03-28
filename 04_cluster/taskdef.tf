locals {
      app_image      = var.app_image
      app_port       = var.app_port
      fargate_cpu    = var.fargate_cpu
      fargate_memory = var.fargate_memory
      aws_region     = var.aws_region
}


resource "aws_ecs_task_definition" "app" {
  family                   = "cb-app"
  execution_role_arn       = data.terraform_remote_state.usuarios.outputs.ecs_task_execution_role
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions = <<DEFINITION
[
  {
    "name": "app",
    "image": "${local.app_image}",
    "cpu": ${local.fargate_cpu},
    "memory": ${local.fargate_memory},
    "networkMode": "awsvpc",
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/cb-app",
          "awslogs-region": "${local.aws_region}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "portMappings": [
      {
        "containerPort": ${local.app_port},
        "hostPort": ${local.app_port}
      }
    ]
  }
]
DEFINITION
}
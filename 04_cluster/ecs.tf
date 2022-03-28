resource "aws_ecs_cluster" "main" {
  name = "cb-cluster"
}

resource "aws_ecs_service" "main" {
  name            = "cb-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [data.terraform_remote_state.network.outputs.ecs_tasks_sg]
    subnets          = data.terraform_remote_state.network.outputs.subnet_private
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = data.terraform_remote_state.network.outputs.ecs_app_target_group_id
    container_name   = var.container_name
    container_port   = var.app_port
  }
}
output "cluster_id" {
  description = "ID of the EC2 instance"
  value       = aws_ecs_cluster.main.id
}

output "task_def_arn" {
  description = "task def"
  value       = aws_ecs_task_definition.app.arn
}

output "cluster_name" {
  description = "cluster ECS name"
  value       = aws_ecs_cluster.main.name
}

output "service_name" {
  description = "service ECS name"
  value       = aws_ecs_service.main.name
}

output "vpc_arn" {
  description = "VPC arn"
  value       = aws_vpc.vpccluster.arn
}

output "vpc_id" {
  description = "VPC id"
  value       = aws_vpc.vpccluster.id
}

output "lb_arn" {
  description = "Load balance ARN"
  value       = aws_alb.ecs_lb.arn
}

output "ecs_app_target_group_arn" {
  description = "target_group_arn"
  value       = aws_alb_target_group.app.arn
}

output "ecs_app_target_group_id" {
  description = "target_group_arn"
  value       = aws_alb_target_group.app.id
}

output "subnet_private" {
  description = ""
  value       = aws_subnet.private.*.id
}

output "ecs_tasks_sg" {
  value = aws_security_group.ecs_tasks_sg.id
}

output "ecs_lb_sg" {
  value = aws_security_group.lb_sg.id
}
output "alb_hostname" {
  value = aws_alb.ecs_lb.dns_name
}

output "aws_db_subnet_group_id" {
  value = aws_db_subnet_group.default.id
}

output "aws_db_sg_group_id" {
  value = aws_security_group.rds_sg.id
}


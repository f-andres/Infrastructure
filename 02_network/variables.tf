variable "vpc_name" {
  default = "vpccluster"
}

variable "region" {
  description = "AWS region"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "app_port" {
  description = "port for app"
  default     = "3000"
}

variable "db_port" {
  description = "port for app"
  default     = "3306"
}

variable "lb_security_group" {
  description = "sg for load balance"
  default     = "lb-security-group"
}

variable "ecs_task_security_group" {
  description = "sg for load balance"
  default     = "ecs-tasks-security-group"
}

variable "health_check_path" {
  default = "/"
}
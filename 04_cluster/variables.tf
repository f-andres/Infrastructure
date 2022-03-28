variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "cluster_ecs"
}

variable "ecs_auto_scale_role_name" {
  description = "ECS auto scale role Name"
  default     = "myEcsAutoScaleRole"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
#  default     = "274485643978.dkr.ecr.us-east-1.amazonaws.com/python:latest"
  default     = "274485643978.dkr.ecr.us-east-1.amazonaws.com/app:c60adfa2ecce89ba7abe02fd8af7bb8fc82d8719"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 3000
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

variable "container_name" {
  description = "app"
  default     = "app"
}
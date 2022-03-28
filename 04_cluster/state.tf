terraform {
  backend "s3" {
    bucket = "terraform-remote-state-20210403"
    key    = "ecs/terraform.tfstate"
    region = "us-east-1"
  }
}
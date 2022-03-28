terraform {
  backend "s3" {
    bucket = "terraform-remote-state-20210403"
    key    = "ecr/terraform.tfstate"
    region = "us-east-1"
  }
}
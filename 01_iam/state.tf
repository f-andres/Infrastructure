terraform {
  backend "s3" {
    bucket = "terraform-remote-state-20210403"
    key    = "usuarios/terraform.tfstate"
    region = "us-east-1"
  }
}
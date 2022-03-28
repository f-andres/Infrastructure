data "terraform_remote_state" "usuarios" {
  backend = "s3"
  config = {
    bucket = "terraform-remote-state-20210403"
    key    = "usuarios/terraform.tfstate"
    region = "us-east-1"
  }
}


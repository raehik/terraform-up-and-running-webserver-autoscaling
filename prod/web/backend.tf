terraform {
  backend "s3" {
    region         = "eu-central-1"
    bucket         = "aws-raehik-net-terraform-state"
    key            = "prod/web/terraform.tfstate"
    dynamodb_table = "terraform-state"
    encrypt        = true
  }
}

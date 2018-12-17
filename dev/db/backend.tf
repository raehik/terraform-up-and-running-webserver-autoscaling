terraform {
  backend "s3" {
    region         = "eu-central-1"
    bucket         = "aws-raehik-net-terraform-state"
    key            = "dev/db/terraform.tfstate"
    dynamodb_table = "terraform-state"
    encrypt        = true
  }
}

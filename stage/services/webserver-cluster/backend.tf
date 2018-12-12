terraform {
  backend "s3" {
    region         = "eu-central-1"
    bucket         = "aws-raehik-net-terraform-state"
    key            = "stage/services/webserver-cluster/terraform.tfstate"
    dynamodb_table = "terraform-state"
    encrypt        = true
    profile        = "raehik@aws.raehik.net"
  }
}

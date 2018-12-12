variable "terraform_backend_s3_bucket" {
  description = "S3 bucket to keep Terraform state in"
}

variable "terraform_backend_s3_dynamodb_table" {
  description = "DynamoDB table used by Terraform for locking state"
}

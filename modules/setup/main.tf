locals {
  namespace   = "terraform-state-${random_id.suffix.hex}"
  bucket_name = "${local.namespace}"
  table_name  = "${local.namespace}-lock"
}

resource "random_id" "suffix" {
  byte_length = 8
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = local.bucket_name
  acl    = "private"
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = local.table_name
  hash_key       = "LockID"
  read_capacity  = 1
  write_capacity = 1
 
  attribute {
    name = "LockID"
    type = "S"
  }
}

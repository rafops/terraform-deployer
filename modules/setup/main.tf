provider "aws" {
  region = var.aws_region
}

locals {
  bucket_name = "terraform-state-${random_id.suffix.hex}"
  table_name  = "terraform-state-${random_id.suffix.hex}-lock"
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

resource "local_file" "terraform_backend_config" {
  content         = templatefile("${path.module}/templates/terraform.tf.tpl",
    {
      "module"      = basename(abspath(path.module))
      "region"      = var.aws_region
      "bucket_name" = local.bucket_name
      "table_name"  = local.table_name
    }
  )
  filename        = "${path.module}/terraform.tf"
  file_permission = "0644"
}

resource "local_file" "remote_state_config" {
  content         = templatefile("${path.module}/templates/setup.tf.tpl",
    {
      "module"      = basename(abspath(path.module))
      "region"      = var.aws_region
      "bucket_name" = local.bucket_name
      "table_name"  = local.table_name
    }
  )
  filename        = "${path.module}/../setup.tf"
  file_permission = "0644"
}

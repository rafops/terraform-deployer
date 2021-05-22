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

# Used by setup module to generate its own terraform.tf
resource "local_file" "terraform" {
  content         = templatefile("${path.module}/_terraform.tf.tpl",
    {
      "bucket_name" = local.bucket_name
      "module"      = basename(abspath(path.module))
      "region"      = var.aws_region
      "table_name"  = local.table_name
    }
  )
  filename        = "${path.module}/terraform.tf"
  file_permission = "0644"
}

# Used by new modules to generate their own terraform.tf
resource "local_file" "remote" {
  content         = templatefile("${path.module}/_remote.tf.tpl",
    {
      "bucket_name" = local.bucket_name
      "module"      = basename(abspath(path.module))
      "region"      = var.aws_region
      "table_name"  = local.table_name
    }
  )
  filename        = "${path.module}/remote.tf"
  file_permission = "0644"
}

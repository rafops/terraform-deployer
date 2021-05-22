data "terraform_remote_state" "remote" {
  backend = "s3"
  config  = {
    bucket         = "${bucket_name}"
    dynamodb_table = "${table_name}"
    encrypt        = true
    key            = "${module}/terraform.tfstate"
    region         = "${region}"
  }
}

resource "local_file" "module_backend_config" {
  count           = basename(abspath(path.module)) == "setup" ? 0 : 1
  content         = templatefile("$${path.module}/_terraform.tf.tpl",
    {
      "module"      = basename(abspath(path.module))
      "region"      = var.aws_region
      "bucket_name" = data.terraform_remote_state.remote.outputs.terraform_state_bucket
      "table_name"  = data.terraform_remote_state.remote.outputs.terraform_state_lock_table
    }
  )
  filename        = "$${path.module}/terraform.tf"
  file_permission = "0644"
}

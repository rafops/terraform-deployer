provider "aws" {
  region = var.aws_region
}

module "terraform_backend" {
  source      = "./modules/terraform-backend"
  output_file = "${path.module}/terraform_backend.tf"
}

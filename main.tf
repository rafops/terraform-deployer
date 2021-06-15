provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment_name
      Owner       = var.environment_owner
    }
  }
}

data "aws_region" "current" {}

module "terraform_backend" {
  source      = "./modules/terraform-backend"
  output_file = "${path.module}/terraform.tf"
}

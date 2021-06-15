output "environment_name" {
  value = var.environment_name
}

output "environment_owner" {
  value = var.environment_owner
}

output "aws_region" {
  value = data.aws_region.current.name
}

output "pgp_key" {
  value = var.pgp_key
}

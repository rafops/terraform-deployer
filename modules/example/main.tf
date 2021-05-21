locals {
  example = "${random_id.example.hex}-${var.aws_region}"
}

resource "random_id" "example" {
  byte_length = 8
}

terraform {
  backend "local" {}
}

variable "endpoint_port" {
  type    = string
  default = "4566"
}

provider "aws" {
  access_key                  = "access"
  secret_key                  = "secret"
  region                      = "us-east-1"
  s3_force_path_style         = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  endpoints {
    ec2      = "http://localhost:${var.endpoint_port}"
    iam      = "http://localhost:${var.endpoint_port}"
    redshift = "http://localhost:${var.endpoint_port}"
  }
}

resource "aws_vpc" "redshift_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_security_group" "redshift_sg" {
  vpc_id = aws_vpc.redshift_vpc.id
}
resource "aws_security_group_rule" "allow_redshift_connection" {
  from_port         = 5439
  protocol          = "TCP"
  security_group_id = aws_security_group.redshift_sg.id
  to_port           = 5439
  cidr_blocks = [
  "0.0.0.0/0"]
  ipv6_cidr_blocks = [
  "::/0"]
  type = "ingress"
}

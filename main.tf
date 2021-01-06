terraform {
  backend "local" {}
}

variable "endpoint_port" {
  type = string
  default = "4566"
}

provider "aws" {
  access_key = "access"
  secret_key = "secret"
  region = "us-east-1"
  s3_force_path_style = true
  skip_credentials_validation = true
  skip_metadata_api_check = true
  skip_requesting_account_id = true
  endpoints {
    apigateway = "http://localhost:${var.endpoint_port}"
    cloudformation = "http://localhost:${var.endpoint_port}"
    cloudwatch = "http://localhost:${var.endpoint_port}"
    dynamodb = "http://localhost:${var.endpoint_port}"
    es = "http://localhost:${var.endpoint_port}"
    ec2 = "http://localhost:${var.endpoint_port}"
    firehose = "http://localhost:${var.endpoint_port}"
    iam = "http://localhost:${var.endpoint_port}"
    kinesis = "http://localhost:${var.endpoint_port}"
    lambda = "http://localhost:${var.endpoint_port}"
    cloudwatchlogs = "http://localhost:${var.endpoint_port}"
    route53 = "http://localhost:${var.endpoint_port}"
    redshift = "http://localhost:${var.endpoint_port}"
    s3 = "http://localhost:${var.endpoint_port}"
    secretsmanager = "http://localhost:${var.endpoint_port}"
    ses = "http://localhost:${var.endpoint_port}"
    sns = "http://localhost:${var.endpoint_port}"
    sqs = "http://localhost:${var.endpoint_port}"
    ssm = "http://localhost:${var.endpoint_port}"
    stepfunctions = "http://localhost:${var.endpoint_port}"
    sts = "http://localhost:${var.endpoint_port}"
  }
}

resource "aws_vpc" "redshift_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "redshif_subnet" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.redshift_vpc.id
}

resource "aws_redshift_subnet_group" "redshift_subnet_group" {
  name = "my-redshift-subnet-group"
  subnet_ids = [
    aws_subnet.redshif_subnet.id]
}

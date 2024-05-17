terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region     = var.awsRegion
  access_key = var.access_key
  secret_key = var.secret_key
  #   profile = "gangabadiger"
}

resource "aws_secretsmanager_secret" "poc" {
  name        = var.secretName
  description = "This is an example secret"

  tags = {
    "Environment" = "dev"
  }
}

resource "aws_secretsmanager_secret_version" "pocversion" {
  secret_id     = aws_secretsmanager_secret.poc.id
  secret_string = jsonencode({
    username = "test",
    password = "test123"
  })
}

output "secret_arn" {
  value = aws_secretsmanager_secret.poc.arn
}

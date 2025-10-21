terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project   = "CI/CD-platform"
      Creator   = "Ali-G"
      ManagedBy = "Terraform"
    }
  }
}

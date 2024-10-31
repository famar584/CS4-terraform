# versions.tf

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"  # Certifique-se de que a versão é 4.0 ou superior
    }
  }
}


provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.session_token
}

module "aws_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = "10.0.0.0/16"

  azs             = var.AZ
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id = module.aws_vpc.vpc_id
}

module "cloudmap" {
  source         = "finisterra-io/cloudmap/aws"
  version        = "1.0.1"
  namespace_name = "cloudmap"
  vpc_name       = var.vpc_name
}

module "amplify" {
  source      = "clouddrove/amplify/aws"
  version     = "1.4.1"
  name        = "amplify"
  branches    = { branch_name = var.amplify }
}

module "labels" {
  source  = "clouddrove/labels/aws"
  version = "1.3.0"
}

module "apigateway-v2" {
  source                = "terraform-aws-modules/apigateway-v2/aws"
  version               = "5.2.0"
  create_domain_records = false
  domain_name           = "apigateway_domain"
}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "5.1.1"
}

module "route53" {
  source  = "terraform-aws-modules/route53/aws"
  version = "4.1.0"
}
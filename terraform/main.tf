terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  backend "s3" {
    # Backend configuration should be provided via terraform init
    # terraform init -backend-config="bucket=your-bucket" -backend-config="key=your-key" etc.
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

module "storage" {
  source = "./modules/storage"
  
  project_name = var.project_name
  account_id   = data.aws_caller_identity.current.account_id
  aws_region   = var.aws_region
}

module "networking" {
  source = "./modules/networking"
  
  project_name = var.project_name
  vpc_cidr     = "10.0.0.0/16"
}

module "iam" {
  source = "./modules/iam"
  
  project_name = var.project_name
  account_id   = data.aws_caller_identity.current.account_id
  aws_region   = var.aws_region
  
  bronze_bucket_arn = module.storage.bronze_bucket_arn
  silver_bucket_arn = module.storage.silver_bucket_arn
  gold_bucket_arn   = module.storage.gold_bucket_arn
  logs_bucket_arn   = module.storage.logs_bucket_arn
}

module "glue" {
  source = "./modules/glue"
  
  project_name = var.project_name
}

module "compute" {
  source = "./modules/compute"
  
  project_name                = var.project_name
  account_id                  = data.aws_caller_identity.current.account_id
  aws_region                  = var.aws_region
  ec2_key_name               = var.ec2_key_name
  
  subnet_id                  = module.networking.public_subnet_id
  master_security_group_id   = module.networking.master_security_group_id
  worker_security_group_id   = module.networking.worker_security_group_id
  
  emr_service_role_arn       = module.iam.emr_service_role_arn
  emr_instance_profile_arn   = module.iam.emr_instance_profile_arn
  
  gold_bucket_name           = module.storage.gold_bucket_name
  bootstrap_bucket_name      = module.storage.bootstrap_bucket_name
}

module "monitoring" {
  source = "./modules/monitoring"
  
  project_name     = var.project_name
  emr_cluster_id   = module.compute.emr_cluster_id
}

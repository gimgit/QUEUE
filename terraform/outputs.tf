output "account_id" {
  description = "AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "bronze_bucket_name" {
  description = "Name of the bronze S3 bucket"
  value       = module.storage.bronze_bucket_name
}

output "silver_bucket_name" {
  description = "Name of the silver S3 bucket"
  value       = module.storage.silver_bucket_name
}

output "gold_bucket_name" {
  description = "Name of the gold S3 bucket"
  value       = module.storage.gold_bucket_name
}

output "emr_logs_bucket_name" {
  description = "Name of the EMR logs S3 bucket"
  value       = module.storage.logs_bucket_name
}

output "bootstrap_bucket_name" {
  description = "Name of the bootstrap S3 bucket"
  value       = module.storage.bootstrap_bucket_name
}

output "emr_service_role_arn" {
  description = "ARN of the EMR service role"
  value       = module.iam.emr_service_role_arn
}

output "emr_ec2_instance_profile_arn" {
  description = "ARN of the EMR EC2 instance profile"
  value       = module.iam.emr_instance_profile_arn
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.networking.vpc_id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.networking.public_subnet_id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = module.networking.private_subnet_id
}

output "emr_master_sg_id" {
  description = "ID of the EMR master security group"
  value       = module.networking.master_security_group_id
}

output "emr_cluster_id" {
  description = "ID of the EMR cluster"
  value       = module.compute.emr_cluster_id
}

output "emr_cluster_master_public_dns" {
  description = "Public DNS of the EMR cluster master node"
  value       = module.compute.emr_cluster_master_public_dns
}

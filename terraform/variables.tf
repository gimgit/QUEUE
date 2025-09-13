variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "emr-workshop"
}

variable "ec2_key_name" {
  description = "EC2 Key Pair name for EMR cluster"
  type        = string
}

variable "backend_bucket" {
  description = "S3 bucket for Terraform state"
  type        = string
}

variable "backend_key" {
  description = "S3 key for Terraform state file"
  type        = string
}

variable "backend_region" {
  description = "AWS region for Terraform state bucket"
  type        = string
  default     = "us-east-1"
}

variable "dynamodb_table" {
  description = "DynamoDB table for Terraform state locking"
  type        = string
}
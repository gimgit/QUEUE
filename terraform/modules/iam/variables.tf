variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "bronze_bucket_arn" {
  description = "ARN of bronze S3 bucket"
  type        = string
}

variable "silver_bucket_arn" {
  description = "ARN of silver S3 bucket"
  type        = string
}

variable "gold_bucket_arn" {
  description = "ARN of gold S3 bucket"
  type        = string
}

variable "logs_bucket_arn" {
  description = "ARN of logs S3 bucket"
  type        = string
}

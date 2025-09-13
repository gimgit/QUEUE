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

# Networking variables
variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "public_availability_zone" {
  description = "Availability zone for public subnet"
  type        = string
  default     = "us-east-1a"
}

variable "private_availability_zone" {
  description = "Availability zone for private subnet"
  type        = string
  default     = "us-east-1b"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed for SSH access"
  type        = string
  default     = "10.0.0.0/16"
}

# EMR variables
variable "emr_release_label" {
  description = "EMR release label"
  type        = string
  default     = "emr-6.15.0"
}

variable "master_instance_type" {
  description = "EMR master instance type"
  type        = string
  default     = "m5.xlarge"
}

variable "core_instance_type" {
  description = "EMR core instance type"
  type        = string
  default     = "m5.xlarge"
}

variable "core_instance_count" {
  description = "Number of core instances"
  type        = number
  default     = 2
}

variable "ebs_size" {
  description = "EBS volume size for core instances"
  type        = number
  default     = 32
}
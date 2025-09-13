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

variable "ec2_key_name" {
  description = "EC2 Key Pair name"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "Subnet ID for EMR cluster"
  type        = string
}

variable "master_security_group_id" {
  description = "Security group ID for EMR master"
  type        = string
}

variable "worker_security_group_id" {
  description = "Security group ID for EMR workers"
  type        = string
}

variable "emr_service_role_arn" {
  description = "EMR service role ARN"
  type        = string
}

variable "emr_instance_profile_arn" {
  description = "EMR instance profile ARN"
  type        = string
}

variable "gold_bucket_name" {
  description = "Gold bucket name"
  type        = string
}

variable "bootstrap_bucket_name" {
  description = "Bootstrap bucket name"
  type        = string
}

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

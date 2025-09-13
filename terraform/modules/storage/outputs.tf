output "bronze_bucket_name" {
  value = aws_s3_bucket.bronze.bucket
}

output "silver_bucket_name" {
  value = aws_s3_bucket.silver.bucket
}

output "gold_bucket_name" {
  value = aws_s3_bucket.gold.bucket
}

output "logs_bucket_name" {
  value = aws_s3_bucket.emr_logs.bucket
}

output "bootstrap_bucket_name" {
  value = aws_s3_bucket.bootstrap_bucket.bucket
}

output "bronze_bucket_arn" {
  value = aws_s3_bucket.bronze.arn
}

output "silver_bucket_arn" {
  value = aws_s3_bucket.silver.arn
}

output "gold_bucket_arn" {
  value = aws_s3_bucket.gold.arn
}

output "logs_bucket_arn" {
  value = aws_s3_bucket.emr_logs.arn
}

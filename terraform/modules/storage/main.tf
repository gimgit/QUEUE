# Data lake S3 buckets
resource "aws_s3_bucket" "bronze" {
  bucket = "${var.project_name}-bronze-${var.account_id}"
}

resource "aws_s3_bucket" "silver" {
  bucket = "${var.project_name}-silver-${var.account_id}"
}

resource "aws_s3_bucket" "gold" {
  bucket = "${var.project_name}-gold-${var.account_id}"
}

resource "aws_s3_bucket" "emr_logs" {
  bucket = "${var.project_name}-emr-logs-${var.account_id}"
}

resource "aws_s3_bucket" "bootstrap_bucket" {
  bucket        = "aws-emr-resources-${var.account_id}-${var.aws_region}"
  force_destroy = true
}

# Versioning
resource "aws_s3_bucket_versioning" "bronze" {
  bucket = aws_s3_bucket.bronze.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "silver" {
  bucket = aws_s3_bucket.silver.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "gold" {
  bucket = aws_s3_bucket.gold.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "emr_logs_versioning" {
  bucket = aws_s3_bucket.emr_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "bootstrap_bucket_versioning" {
  bucket = aws_s3_bucket.bootstrap_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "bronze" {
  bucket = aws_s3_bucket.bronze.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "silver" {
  bucket = aws_s3_bucket.silver.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "gold" {
  bucket = aws_s3_bucket.gold.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "emr_logs_encryption" {
  bucket = aws_s3_bucket.emr_logs.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Bootstrap script
resource "aws_s3_object" "iceberg_bootstrap" {
  bucket = aws_s3_bucket.bootstrap_bucket.bucket
  key    = "bootstrap-actions/install-iceberg.sh"
  content = <<-EOF
#!/bin/bash
set -e

sudo mkdir -p /usr/lib/spark/jars/

sudo wget -O /usr/lib/spark/jars/iceberg-spark-runtime-3.3_2.12-1.4.2.jar \
  https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.3_2.12/1.4.2/iceberg-spark-runtime-3.3_2.12-1.4.2.jar

sudo wget -O /usr/lib/spark/jars/iceberg-aws-bundle-1.4.2.jar \
  https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-aws-bundle/1.4.2/iceberg-aws-bundle-1.4.2.jar

sudo chmod 644 /usr/lib/spark/jars/iceberg-*.jar

echo "Iceberg JARs installed successfully"
EOF

  depends_on = [aws_s3_bucket.bootstrap_bucket]
}

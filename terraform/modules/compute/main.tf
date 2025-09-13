resource "aws_emr_cluster" "iceberg_cluster" {
  name          = "${var.project_name}-emr-cluster"
  release_label = "emr-6.15.0"
  applications  = ["Spark", "Hadoop", "Hive"]

  termination_protection            = false
  keep_job_flow_alive_when_no_steps = true
  
  # Enable logging
  log_uri = "s3://emr-iceberg-emr-logs-${var.account_id}/logs/"

  ec2_attributes {
    key_name                          = var.ec2_key_name
    subnet_id                         = var.subnet_id
    emr_managed_master_security_group = var.master_security_group_id
    emr_managed_slave_security_group  = var.worker_security_group_id
    instance_profile                  = var.emr_instance_profile_arn
  }

  master_instance_group {
    instance_type = "m5.xlarge"
  }

  core_instance_group {
    instance_type  = "m5.xlarge"
    instance_count = 2

    ebs_config {
      size                 = 32
      type                 = "gp3"
      volumes_per_instance = 1
    }
  }

  configurations_json = jsonencode([
    {
      "Classification" : "spark-hive-site",
      "Properties" : {
        "hive.metastore.client.factory.class" : "com.amazonaws.glue.catalog.metastore.AWSGlueDataCatalogHiveClientFactory"
      }
    },
    {
      "Classification" : "spark-defaults",
      "Properties" : {
        "spark.serializer" : "org.apache.spark.serializer.KryoSerializer"
      }
    }
  ])

  bootstrap_action {
    path = "s3://${var.bootstrap_bucket_name}/bootstrap-actions/install-iceberg.sh"
    name = "Install Iceberg"
  }

  service_role = var.emr_service_role_arn

  tags = {
    Name = "${var.project_name}-emr-cluster"
  }
}

resource "aws_cloudwatch_log_group" "emr_cluster_logs" {
  name              = "/aws/emr/${var.project_name}-cluster"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "spark_logs" {
  name              = "/aws/emr/spark/${var.project_name}"
  retention_in_days = 7
}

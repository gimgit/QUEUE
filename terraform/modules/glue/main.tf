resource "aws_glue_catalog_database" "iceberg_database" {
  name        = "${var.project_name}-iceberg-db"
  description = "Database for Apache Iceberg tables in data lake"
}

resource "aws_glue_catalog_database" "bronze_database" {
  name        = "${var.project_name}-bronze-db"
  description = "Database for bronze layer raw data"
}

resource "aws_glue_catalog_database" "silver_database" {
  name        = "${var.project_name}-silver-db"
  description = "Database for silver layer processed data"
}

resource "aws_glue_catalog_database" "gold_database" {
  name        = "${var.project_name}-gold-db"
  description = "Database for gold layer curated data"
}

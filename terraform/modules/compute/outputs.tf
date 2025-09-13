output "emr_cluster_id" {
  value = aws_emr_cluster.iceberg_cluster.id
}

output "emr_cluster_master_public_dns" {
  value = aws_emr_cluster.iceberg_cluster.master_public_dns
}

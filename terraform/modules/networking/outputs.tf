output "vpc_id" {
  value = aws_vpc.emr_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.emr_public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.emr_private_subnet.id
}

output "master_security_group_id" {
  value = aws_security_group.emr_master_sg.id
}

output "worker_security_group_id" {
  value = aws_security_group.emr_worker_sg.id
}

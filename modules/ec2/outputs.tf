output "ec2_instance_ids" {
  value = aws_instance.monitoring[*].id
}

output "ec2_private_ips" {
  value = aws_instance.monitoring[*].private_ip
}

output "eks_nodes_sg_id" {
  value = aws_security_group.eks_nodes.id
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_monitoring.id
}

output "rds_sg_id" {
  value = aws_security_group.rds.id
}

output "alb_sg_id" {
  value = aws_security_group.alb.id
}

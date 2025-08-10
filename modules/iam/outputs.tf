output "eks_node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
}

output "ec2_monitoring_role_arn" {
  value = aws_iam_role.ec2_monitoring_role.arn
}


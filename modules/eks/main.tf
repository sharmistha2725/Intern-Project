# EKS Cluster
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.eks_node_role_arn

  vpc_config {
    subnet_ids = var.private_subnet_ids
  }

  # Ensure Kubernetes version is stable for beginners
  version = "1.29"

  tags = {
    Name = var.cluster_name
  }
}

# EKS Node Group
resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-nodes"
  node_role_arn   = var.eks_node_role_arn
  subnet_ids      = var.private_subnet_ids
  instance_types  = [var.node_instance_type]
  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  tags = {
    Name = "${var.cluster_name}-nodes"
  }

  depends_on = [aws_eks_cluster.this]
}

output "ecs_cluster_names" {
  value = aws_ecs_cluster.this[*].name
}

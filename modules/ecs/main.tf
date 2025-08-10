# ECS Clusters (One per AZ)
resource "aws_ecs_cluster" "this" {
  count = length(var.availability_zones)

  name = "monitoring-ecs-${count.index + 1}"

  tags = {
    Name = "monitoring-ecs-${count.index + 1}"
  }
}

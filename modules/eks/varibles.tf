variable "cluster_name" {}
variable "private_subnet_ids" { type = list(string) }
variable "node_instance_type" {}
variable "eks_node_role_arn" {}

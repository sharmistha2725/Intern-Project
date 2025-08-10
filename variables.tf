variable "aws_region" {}
variable "vpc_cidr" {}
variable "public_subnet_cidrs" { type = list(string) }
variable "private_subnet_cidrs" { type = list(string) }
variable "monitoring_subnet_cidrs" { type = list(string) }
variable "availability_zones" { type = list(string) }
variable "eks_cluster_name" {}
variable "eks_node_instance_type" {}
variable "acm_certificate_arn" {}
variable "s3_bucket_name" {}
variable "ec2_key_name" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}

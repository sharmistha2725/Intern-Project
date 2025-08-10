provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.8.0"
    }
  }
}

# 1. VPC & Subnets
module "vpc" {
  source                    = "./modules/vpc"
  vpc_cidr                  = var.vpc_cidr
  public_subnet_cidrs       = var.public_subnet_cidrs
  private_subnet_cidrs      = var.private_subnet_cidrs
  monitoring_subnet_cidrs   = var.monitoring_subnet_cidrs
  availability_zones        = var.availability_zones
}

# 2. Security Groups
module "security_groups" {
  source = "./modules/security-groups"
  vpc_id = module.vpc.vpc_id
}

# 3. IAM
module "iam" {
  source = "./modules/iam"
}

# 4. EKS
module "eks" {
  source              = "./modules/eks"
  cluster_name        = var.eks_cluster_name
  private_subnet_ids  = module.vpc.private_subnet_ids
  node_instance_type  = var.eks_node_instance_type
  eks_node_role_arn   = module.iam.eks_node_role_arn
}


# 5. EC2 (Monitoring Subnet)
module "ec2" {
  source                = "./modules/ec2"
  subnet_ids            = module.vpc.monitoring_subnet_ids
  security_group_ids    = [module.security_groups.ec2_sg_id]
  ec2_key_name          = var.ec2_key_name
  ec2_monitoring_role_arn = module.iam.ec2_monitoring_role_arn
}


# 6. RDS
module "rds" {
  source            = "./modules/rds"
  subnet_ids        = module.vpc.monitoring_subnet_ids
  security_group_id = module.security_groups.rds_sg_id
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
}


# 7. ECS
module "ecs" {
  source             = "./modules/ecs"
  availability_zones = var.availability_zones
}


# 8. ALB for Grafana
module "alb" {
  source            = "./modules/alb"
  public_subnet_ids = module.vpc.public_subnet_ids
  security_group_id = module.security_groups.alb_sg_id
  certificate_arn   = var.acm_certificate_arn
  vpc_id            = module.vpc.vpc_id
}


# 9. S3 for Grafana Dashboards
module "s3" {
  source      = "./modules/s3"
  bucket_name = var.s3_bucket_name
}

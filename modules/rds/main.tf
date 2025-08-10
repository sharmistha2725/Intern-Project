# Subnet Group for RDS
resource "aws_db_subnet_group" "this" {
  name       = "monitoring-rds-subnet-group"
  subnet_ids = var.subnet_ids
  tags = {
    Name = "monitoring-rds-subnet-group"
  }
}

# RDS Instances (One per AZ)
resource "aws_db_instance" "this" {
  count                   = length(var.subnet_ids)
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = var.db_instance_class
  identifier              = "monitoring-db-${count.index + 1}"
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [var.security_group_id]
  skip_final_snapshot     = true
  multi_az                = false
  publicly_accessible     = false
  backup_retention_period = 7

  tags = {
    Name = "monitoring-db-${count.index + 1}"
  }
}

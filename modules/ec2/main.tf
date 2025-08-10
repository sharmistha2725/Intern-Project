# EC2 Instances for Monitoring (One per AZ)
resource "aws_instance" "monitoring" {
  count         = length(var.subnet_ids)
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.ec2_instance_type
  subnet_id     = var.subnet_ids[count.index]
  vpc_security_group_ids = var.security_group_ids
  key_name      = var.ec2_key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_monitoring.name

  tags = {
    Name = "monitoring-ec2-${count.index + 1}"
  }
}

# Data source for Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Instance Profile for EC2 IAM Role
resource "aws_iam_instance_profile" "ec2_monitoring" {
  name = "ec2-monitoring-instance-profile"
  role = var.ec2_monitoring_role_arn
}

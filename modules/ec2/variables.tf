variable "subnet_ids" { type = list(string) }
variable "security_group_ids" { type = list(string) }
variable "ec2_instance_type" { default = "t3.medium" }
variable "ec2_key_name" {} # for SSH if needed
variable "ec2_monitoring_role_arn" {}

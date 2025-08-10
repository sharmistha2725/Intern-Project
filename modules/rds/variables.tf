variable "subnet_ids" { type = list(string) }
variable "security_group_id" {}
variable "db_instance_class" { default = "db.r3.medium" }
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}

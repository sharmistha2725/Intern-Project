variable "public_subnet_ids" { type = list(string) }
variable "security_group_id" {}
variable "certificate_arn" {}
variable "vpc_id" {}
variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS"
  type        = string
  default     = ""
}

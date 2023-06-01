
# Tags
variable "project" {}
variable "createdBy" {}
# General 
variable "aws_region" {}
# EC2 
variable "ami" {}
variable "availability_zone" {}
variable "buckets" {
  description = "s3 buckets list"
  type = list(string)
  default = ["images", "lambda-s3"]
}
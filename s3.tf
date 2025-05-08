# /*
#
# resource "random_pet" "lambda_bucket_name" {
#   prefix = "learn-terraform-functions"
#   length = 4
# }
#
# resource "aws_s3_bucket" "lambda_bucket" {
#   bucket = random_pet.lambda_bucket_name.id
# }
#
# /*resource "aws_s3_bucket_acl" "bucket_acl" {
#   bucket = aws_s3_bucket.lambda_bucket.id
#   acl    = "private"
# }
# */
#
# resource "random_pet" "this" {
#   length = 2
# }
#
# module "s3_bucket" {
#   for_each = toset(var.buckets)
#   source  = "terraform-aws-modules/s3-bucket/aws"
#   version = "~> 3.0"
#
#   bucket_prefix = "${random_pet.this.id}-${each}"
#   force_destroy = true
#
#   # S3 bucket-level Public Access Block configuration
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
#
#   versioning = {
#     enabled = true
#   }
# }
#
# output "s3_bucket_id" {
#   description = "The name of the bucket."
#   value       = module.s3_bucket[*].s3_bucket_id
# }
#
# output "s3_bucket_arn" {
#   description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
#   value       = module.s3_bucket[*].s3_bucket_arn
# }
terraform {
  backend "s3" {
    bucket = "dima9000"
    key    = "my_stack"
    region = "us-east-1"
  }
}

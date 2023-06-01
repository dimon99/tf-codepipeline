terraform {
  backend "s3" {
    bucket = "cluster.dima-test.ml"
    key    = "my_stack"
    region = "us-east-1"
  }
}

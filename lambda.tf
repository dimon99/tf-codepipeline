/*data "aws_caller_identity" "current" {}
data "aws_organizations_organization" "this" {}

module "lambda_function_for_each" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-lambda.git"

  for_each = toset(["dev", "staging", "prod"])

  function_name = "my-${each.value}"
  description   = "My awesome lambda function"
  handler       = "hello.handler"
  runtime       = "nodejs12.x"
  publish       = true
  source_path = "./hello-world"
  store_on_s3 = true
  s3_bucket   = module.s3_bucket["lambda-s3"].s3_bucket_id
  s3_prefix   = "lambda-builds-${each.value}/"
  environment_variables = {
    Hello      = "World"
    Serverless = "Terraform"
  }
  allowed_triggers = {
    Config = {
      principal        = "config.amazonaws.com"
      principal_org_id = data.aws_organizations_organization.this.id
    }
    APIGatewayAny = {
      service    = "apigateway"
      source_arn = "arn:aws:execute-api:us-east-1:${data.aws_caller_identity.current.account_id}:aqnku8akd0/*/*/*"
    },
    APIGatewayDevPost = {
      service    = "apigateway"
      source_arn = "arn:aws:execute-api:us-east-1:${data.aws_caller_identity.current.account_id}:aqnku8akd0/dev/POST/*"
    },
    OneRule = {
      principal  = "events.amazonaws.com"
      source_arn = "arn:aws:events:us-east-1:${data.aws_caller_identity.current.account_id}:rule/RunDaily"
    }
  }

   attach_policy_statements = true
  policy_statements = {
    dynamodb = {
      effect    = "Allow",
      actions   = ["dynamodb:BatchWriteItem"],
      resources = ["arn:aws:dynamodb:us-east-1:052212379155:table/Test"]
    },
    s3_read = {
      effect    = "Deny",
      actions   = ["s3:HeadObject", "s3:GetObject"],
      resources = ["arn:aws:s3:::my-bucket/*"]
    }
  }
}*/
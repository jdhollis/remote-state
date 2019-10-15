terraform {
  required_version = "~> 0.12.0"

  # TODO: Uncomment and update backend configuration here.
  #  backend "s3" {
  #    bucket         = "[PREFIX]-tools-terraform-state"
  #    key            = "remote-state/terraform.tfstate"
  #    region         = "us-east-1"
  #    dynamodb_table = "[PREFIX]-tools-terraform-state-locking"
  #    profile        = "ops-tools"
  #    encrypt        = true
  #    kms_key_id     = "[KMS_KEY_ID]"
  #  }
}

provider "aws" {
  version = "~> 2.32"
  region  = var.region
  profile = "ops-tools"
}

data "aws_iam_role" "ops" {
  name = "Ops"
}

module "tools" {
  source = "./env"

  env     = "tools"
  ops_arn = data.aws_iam_role.ops.arn
  prefix  = var.prefix
}

module "dev" {
  source = "./env"

  env     = "dev"
  ops_arn = data.aws_iam_role.ops.arn
  prefix  = var.prefix
}

module "stage" {
  source = "./env"

  env     = "stage"
  ops_arn = data.aws_iam_role.ops.arn
  prefix  = var.prefix
}

module "prod" {
  source = "./env"

  env     = "prod"
  ops_arn = data.aws_iam_role.ops.arn
  prefix  = var.prefix
}

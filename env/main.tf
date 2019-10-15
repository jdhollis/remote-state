module "state_key" {
  source = "github.com/jdhollis/s3-kms-key"

  alias_name = "${var.prefix}-${var.env}-terraform-state-key"
  principals = [var.ops_arn]
}

resource "aws_s3_bucket" "state" {
  bucket = "${var.prefix}-${var.env}-terraform-state"

  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "state_locking" {
  name         = "${var.prefix}-${var.env}-terraform-state-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


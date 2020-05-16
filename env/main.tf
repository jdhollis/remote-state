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

resource "aws_s3_bucket_public_access_block" "state" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = aws_s3_bucket.state.id
  ignore_public_acls      = true
  restrict_public_buckets = true
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

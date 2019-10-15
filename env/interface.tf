variable "env" {}
variable "ops_arn" {}
variable "prefix" {}

output "outputs" {
  value = {
    bucket_arn         = aws_s3_bucket.state.arn
    bucket_name        = aws_s3_bucket.state.id
    key_arn            = module.state_key.arn
    key_id             = module.state_key.id
    locking_table_arn  = aws_dynamodb_table.state_locking.arn
    locking_table_name = aws_dynamodb_table.state_locking.id
  }
}


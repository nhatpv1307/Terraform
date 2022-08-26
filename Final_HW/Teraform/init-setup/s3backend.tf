# Local variables

locals {
  name                = "devops"
  region              = "ap-southeast-1"
  bucket_name         = "devops-terraform-state-102"
  dynamodb_table_name = "devops-terraform-state"
}

# S3 bucket

resource "aws_s3_bucket" "terraform-state" {
  bucket = local.bucket_name
}

resource "aws_s3_bucket_acl" "s3_acl" {
  bucket = aws_s3_bucket.terraform-state.id

  acl = "private"
}

resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.terraform-state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.terraform-state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# DynamoDB table

resource "aws_dynamodb_table" "terraform-state" {
  name           = local.dynamodb_table_name
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

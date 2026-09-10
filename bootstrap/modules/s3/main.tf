resource "aws_s3_bucket" "gatus-backend" {
  bucket = var.bucket-name

  tags = {
    Name = var.bucket-name-tag
  }
}

resource "aws_s3_bucket_ownership_controls" "disable-acl" {
  bucket = aws_s3_bucket.gatus-backend.id
  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_public_access_block" "public-block" {
  bucket = aws_s3_bucket.gatus-backend.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "backend-versioning" {
  bucket = aws_s3_bucket.gatus-backend.id
  versioning_configuration {
    status = var.versioning_configuration
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default-encrypt" {
  bucket = aws_s3_bucket.gatus-backend.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.sse_algorithm
    }
    bucket_key_enabled = true
  }
}
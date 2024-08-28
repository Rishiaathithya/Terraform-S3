resource "aws_s3_bucket" "bucket_name" {
  bucket = var.bucket
}


resource "aws_s3_bucket_ownership_controls" "bucket_own" {
  bucket = aws_s3_bucket.bucket_name.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


resource "aws_s3_bucket_public_access_block" "buc_pub_acc" {
  bucket = aws_s3_bucket.bucket_name.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_acl" "buc_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bucket_own,
    aws_s3_bucket_public_access_block.buc_pub_acc,
  ]

  bucket = aws_s3_bucket.bucket_name.id
  acl    = "public-read"
}


resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.bucket_name.id
  key    = "index.html"
  source = "Website/index.html"
  acl = "public-read"
  content_type = "text/html"
}


resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.bucket_name.id
  key    = "error.html"
  source = "Website/error.html"
  acl = "public-read"
  content_type = "text/html"
}


resource "aws_s3_object" "cart" {
  bucket = aws_s3_bucket.bucket_name.bucket
  key    = "cart.html"
  source = "Website/cart.html"
  acl    = "public-read"
  content_type = "text/html"
}


resource "aws_s3_object" "account" {
  bucket = aws_s3_bucket.bucket_name.bucket
  key    = "account.html"
  source = "Website/account.html"
  acl    = "public-read"
  content_type = "text/html"
}


resource "aws_s3_object" "product" {
  bucket = aws_s3_bucket.bucket_name.bucket
  key    = "product.html"
  source = "Website/product.html"
  acl    = "public-read"
  content_type = "text/html"
}


resource "aws_s3_object" "productdetails" {
  bucket = aws_s3_bucket.bucket_name.bucket
  key    = "productdetails.html"
  source = "Website/productdetails.html"
  acl    = "public-read"
  content_type = "text/html"
}


resource "aws_s3_object" "styles" {
  bucket = aws_s3_bucket.bucket_name.bucket
  key    = "style.css"
  source = "Website/style.css"
  acl    = "public-read"
  content_type = "text/css"
}



resource "aws_s3_object" "priduct_css" {
  bucket = aws_s3_bucket.bucket_name.bucket
  key    = "product.css"
  source = "Website/product.css"
  acl    = "public-read"
  content_type = "text/css"
}





resource "aws_s3_bucket_website_configuration" "web_config" {
   bucket = aws_s3_bucket.bucket_name.id
    index_document {
    suffix = "index.html"
    }

  error_document {
    key = "error.html"
    } 
    depends_on = [aws_s3_bucket_acl.buc_acl] 
}



resource "aws_s3_bucket" "WebBucket" {
  bucket = "web-bucket-s3-2025"
  tags = {
    Name        = "My bucket"
    Environment = "INT"
  }
}

resource "aws_s3_bucket_public_access_block" "WebBucket" {
  bucket = aws_s3_bucket.WebBucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "object" {
  bucket       = "web-bucket-s3-2025"
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket       = "web-bucket-s3-2025"
  key          = "error.html"
  source       = "error.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "WebBucket" {
  bucket = aws_s3_bucket.WebBucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}
resource "aws_s3_bucket_policy" "public_read_access" {
  bucket = aws_s3_bucket.WebBucket.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
	  "Principal": "*",
      "Action": [ "s3:GetObject" ],
      "Resource": [
        "${aws_s3_bucket.WebBucket.arn}",
        "${aws_s3_bucket.WebBucket.arn}/*"
      ]
    }
  ]
}
EOF
}



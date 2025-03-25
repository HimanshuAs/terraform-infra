output "websiteEndpoint" {
  value = aws_s3_bucket.WebBucket.bucket_domain_name

}
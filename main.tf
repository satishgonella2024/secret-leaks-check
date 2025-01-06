resource "aws_s3_bucket" "example" {
  bucket = "my-insecure-bucket"
  acl    = "public-read"
}
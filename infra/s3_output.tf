resource "aws_s3_bucket" "output_bucket" {
  bucket = "text-to-audio-aws-output-${random_id.bucket_suffix.hex}"

  versioning {
    enabled = true
  }
}

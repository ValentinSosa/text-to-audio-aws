resource "aws_s3_bucket" "input_bucket" {
  bucket = "text-to-audio-aws-input-${random_id.bucket_suffix.hex}"

  lifecycle {
    prevent_destroy = true
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "input_bucket" {
  bucket = "text-to-audio-aws-input-${random_id.bucket_suffix.hex}"
}


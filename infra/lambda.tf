resource "aws_lambda_function" "text_to_audio" {
  function_name = "text-to-audio"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "text_to_audio.lambda_handler"
  runtime       = "python3.11"
  timeout       = 30

  filename         = "../lambda/text_to_audio.zip"
  source_code_hash = filebase64sha256("../lambda/text_to_audio.zip")

  environment {
    variables = {
      OUTPUT_BUCKET = aws_s3_bucket.output_bucket.bucket
    }
  }
}

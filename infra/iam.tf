resource "aws_iam_role" "lambda_exec" {
  name = "text-to-audio-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Logs
resource "aws_iam_policy" "lambda_logs" {
  name = "lambda-cloudwatch-logs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = "arn:aws:logs:*:*:*"
    }]
  })
}

# Polly
resource "aws_iam_policy" "lambda_polly" {
  name = "lambda-polly-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["polly:SynthesizeSpeech"]
      Resource = "*"
    }]
  })
}

# S3
resource "aws_iam_policy" "lambda_s3" {
  name = "lambda-s3-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["s3:GetObject"]
        Resource = "arn:aws:s3:::text-to-audio-aws-input-*/*"
      },
      {
        Effect = "Allow"
        Action = ["s3:PutObject"]
        Resource = "arn:aws:s3:::text-to-audio-aws-output-*/*"
      }
    ]
  })
}

# Attachments
resource "aws_iam_role_policy_attachment" "logs" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_logs.arn
}

resource "aws_iam_role_policy_attachment" "polly" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_polly.arn
}

resource "aws_iam_role_policy_attachment" "s3" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_s3.arn
}

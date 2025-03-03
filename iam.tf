resource "aws_iam_role" "zip" {
  name = "spacex-zip-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "zip_cw" {
  name = "spacex-zip-cw-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "${aws_cloudwatch_log_group.cw.arn}:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "zip_cw" {
  role       = aws_iam_role.zip.name
  policy_arn = aws_iam_policy.zip_cw.arn
}

resource "aws_iam_role" "docker" {
  name = "spacex-docker-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "docker_cw" {
  name = "spacex-docker-cw-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "${aws_cloudwatch_log_group.cw.arn}:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "docker_cw" {
  role       = aws_iam_role.docker.name
  policy_arn = aws_iam_policy.docker_cw.arn
}

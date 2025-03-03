resource "aws_lambda_function" "zip" {
  function_name    = "spacex-latest-zip"
  role             = aws_iam_role.zip.arn
  runtime          = "python3.12"
  handler          = "main.lambda_handler"
  filename         = "spacex-latest.zip"
  source_code_hash = data.archive_file.zip.output_base64sha256

  logging_config {
    log_group  = aws_cloudwatch_log_group.cw.name
    log_format = "Text"
  }

  environment {
    variables = {
      API_URL = var.spacex_url
    }
  }
}

resource "aws_lambda_function_url" "zip" {
  function_name      = aws_lambda_function.zip.function_name
  authorization_type = "NONE"
}

resource "aws_lambda_function" "docker" {
  function_name = "spacex-latest-docker"
  role          = aws_iam_role.docker.arn
  package_type  = "Image"
  image_uri     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/spacex-latest:${var.spacex_version}"
  architectures = ["arm64"]
  logging_config {
    log_group  = aws_cloudwatch_log_group.cw.name
    log_format = "Text"
  }

  environment {
    variables = {
      API_URL = var.spacex_url
    }
  }
}

resource "aws_lambda_function_url" "docker" {
  function_name      = aws_lambda_function.docker.function_name
  authorization_type = "NONE"
}

resource "aws_cloudwatch_log_group" "cw" {
  name              = "spacex-logs"
  retention_in_days = 7
}

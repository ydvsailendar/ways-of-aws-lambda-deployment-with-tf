data "archive_file" "zip" {
  type        = "zip"
  source_file = "main.py"
  output_path = "spacex-latest.zip"
}

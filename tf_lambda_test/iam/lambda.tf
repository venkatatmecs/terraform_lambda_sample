locals {
  lambda_zip_location = "outputs/welcome.zip"
}

data "archive_file" "welcome" {
  type        = "zip"
  source_file = "/root/tf_lambda/welcome.py"
  output_path = local.lambda_zip_location
}

resource "aws_lambda_function" "test_lambda" {
  filename      = local.lambda_zip_location
  function_name = "welcome"
  role          = "${aws_iam_role.lambda_role.arn}"
  # handler nothing but the python file(welcome) and hello method name in the python code
  handler       = "welcome.hello"
  runtime       = "python3.8"
  # source_code_hash "filebase64sha256" will pull changes made on the code whenever changes made the file will pull that when u do apply in terraform
  source_code_hash = "${filebase64sha256(local.lambda_zip_location)}"
}


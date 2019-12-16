provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-1"
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.lambda_role.id

  policy = file("/root/tf_lambda/iam/lambda-policy.json")


}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  #policy = "${file("iam/lambda-assume-policy.json")}"
  assume_role_policy = file("/root/tf_lambda/iam/lambda-assume-policy.json")

}


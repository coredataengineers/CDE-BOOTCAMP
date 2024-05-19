resource "aws_iam_group" "developers" {
  name = "developers"
  path = "/users/"
}

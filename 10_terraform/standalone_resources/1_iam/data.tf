
data "aws_iam_user" "example" {
  user_name = "an_example_user_name"
}

data "aws_iam_group" "example" {
  group_name = "an_example_group_name"
}

data "aws_iam_policy" "example" {
  name = "test_policy"
}

data "aws_iam_role" "example" {
  name = "an_example_role_name"
}

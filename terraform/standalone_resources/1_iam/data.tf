# IAM USER
data "aws_iam_user" "example" {
  user_name = "an_example_user_name"
}

# IAM GROUP
data "aws_iam_group" "example" {
  group_name = "an_example_group_name"
}

# IAM ACCESS KEY
data "aws_iam_access_keys" "example" {
  user = "an_example_user_name"
}

# IAM POLICY
data "aws_iam_policy" "example" {
  name = "test_policy"
}

# IAM ROLE
data "aws_iam_role" "example" {
  name = "an_example_role_name"
}

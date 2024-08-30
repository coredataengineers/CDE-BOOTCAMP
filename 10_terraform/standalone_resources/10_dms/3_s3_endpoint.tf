resource "aws_dms_s3_endpoint" "example" {
  endpoint_id             = "donnedtipi"
  endpoint_type           = "target"
  bucket_name             = "beckut_name"
  service_access_role_arn = aws_iam_role.example.arn

  depends_on = [aws_iam_role_policy.example]
}

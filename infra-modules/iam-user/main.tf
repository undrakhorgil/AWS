resource "aws_iam_user" "this" {
  name = var.user_name
  tags = merge(var.tags, {
    ManagedBy = "Terraform"
  })
}
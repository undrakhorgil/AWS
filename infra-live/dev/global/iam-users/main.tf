module "aws_iam_user" {
  source    = "../../../../infra-modules/iam-user"
  user_name = var.user_name
  tags      = local.common_tags
}
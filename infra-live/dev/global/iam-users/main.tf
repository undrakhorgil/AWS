module "aws_iam_user" {
  source    = "../../../../infra-modules/iam-user"
  user_name = var.user_name
  tags      = local.common_tags
}

resource "aws_iam_group" "admin_group" {
  name = "AdminGroup"
}

resource "aws_iam_group_policy_attachment" "admins_admin_access" {
  group      = aws_iam_group.admin_group.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user_group_membership" "user_admins" {
  count = var.add_user_to_admin_group ? 1 : 0

  user = module.aws_iam_user.name # output from your module

  groups = [
    aws_iam_group.admin_group.name
  ]
}
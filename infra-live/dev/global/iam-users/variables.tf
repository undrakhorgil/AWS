variable "user_name" {
  type = string
}

variable "add_user_to_admin_group" {
  description = "Whether to add the IAM user to the admins group"
  type        = bool
  default     = false
}
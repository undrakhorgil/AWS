variable "key_name" {
  type        = string
  description = "Name of the key pair in AWS"
}

variable "public_key" {
  type        = string
  description = "The public key content to be imported into AWS"
}

output "key_name" {
  description = "The key name to attach to EC2 instances"
  value       = aws_key_pair.this.key_name
}

output "public_key" {
  description = "The public key content"
  value       = aws_key_pair.this.public_key
}
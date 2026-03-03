variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to use"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "my_ip" {
  description = "Your public IP for SSH access"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
}
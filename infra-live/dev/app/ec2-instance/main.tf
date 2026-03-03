data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    path = "/Users/mac/Documents/Courses/AWS/infra-live/dev/network/vpc/terraform.tfstate"
  }
}

module "ec2" {
  source = "../../../../infra-modules/ec2-instance"

  instance_name = "dev-ec2-free"
  instance_type = "t3.micro"

  ami_id = data.aws_ami.amazon_linux.id

  subnet_id = data.terraform_remote_state.network.outputs.public_subnet_id
  vpc_id    = data.terraform_remote_state.network.outputs.vpc_id

  my_ip   = var.my_ip
  key_name = "your-keypair-name"
}
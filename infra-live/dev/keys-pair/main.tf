module "dev_key" {
  source          = "../../../infra-modules/key-pair"
  
  key_name        = var.key_name
  public_key      = var.public_key
  }
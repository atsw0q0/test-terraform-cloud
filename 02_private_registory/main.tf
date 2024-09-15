module "network-templates" {
  source  = "app.terraform.io/atsuw0w-test-terraform/network-templates/aws"
  version = "1.0.0"
  # Variables
  pj_tags = {
    name = "fuga"
    env = "test"
  }
  vpc_prefix = {
    prefix     = "net"
    cidr_block = "10.1.0.0/16" 
  }
  subnet ={
    pub = {
      pub_a = {
        prefix           = "pub"
        cidr_block       = "10.1.0.0/24"
        az               = "a"
        is_public_subnet = true
      }
      pub_c = {
        prefix           = "pub"
        cidr_block       = "10.1.1.0/24"
        az               = "c"
        is_public_subnet = true
      }
    }
    pri = {
      pri_a = {
        prefix           = "pri"
        cidr_block       = "10.1.10.0/24"
        az               = "a"
        is_public_subnet = false
      }
      pri_c = {
        prefix           = "pri"
        cidr_block       = "10.1.11.0/24"
        az               = "c"
        is_public_subnet = false
      }
    }
    edp = {
      edp_a = {
        prefix           = "edp"
        cidr_block       = "10.1.20.0/24"
        az               = "a"
        is_public_subnet = false
      }
      edp_c = {
        prefix           = "edp"
        cidr_block       = "10.1.21.0/24"
        az               = "c"
        is_public_subnet = false
      }
    }
  }
}


module "network-templates" {
  source  = "app.terraform.io/atsuw0w-test-terraform/network-templates/aws"
  version = "1.0.0"
  # Variables
  pj_tags = var.pj_tags
  vpc_prefix = {
    prefix     = "net"
    cidr_block = "10.1.0.0/16"
  }
  subnet = {
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


module "ec2-sg" {
  source  = "app.terraform.io/atsuw0w-test-terraform/network-templates/aws//modules/security_group"
  version = "1.0.1-alpha1"
  pj_tags = var.pj_tags

  sg = {
    prefix      = "ec2"
    description = "ec2"
    vpc_id      = module.network-templates.vpc_id
    ingress = {
      https = {
        description = "https"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      http = {
        description = "http"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
  }
}


module "mariadb-sg" {
  source  = "app.terraform.io/atsuw0w-test-terraform/network-templates/aws//modules/security_group"
  version = "1.0.1-alpha1"

  pj_tags = var.pj_tags

  sg = {
    prefix      = "mariadb"
    description = "mariadb"
    vpc_id      = module.network-templates.vpc_id
    ingress = {
      mariadb = {
        description = "mariadb"
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = [module.ec2-sg.sg_id]
      }
    }
  }
}

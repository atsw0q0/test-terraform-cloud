module "network-templates" {
  source  = "app.terraform.io/atsuw0w-test-terraform/network-templates/aws"
  version = "1.0.1"
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
  version = "1.0.1"
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
  version = "1.0.1"

  pj_tags = var.pj_tags

  sg = {
    prefix      = "mariadb"
    description = "mariadb"
    vpc_id      = module.network-templates.vpc_id
    ingress = {
      mariadb = {
        description     = "mariadb"
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        security_groups = [module.ec2-sg.sg_id]
      }
    }
  }
}

module "rds-mysql" {
  source  = "app.terraform.io/atsuw0w-test-terraform/webapp-templates/aws//modules/rds_instance"
  version = "1.0.0"

  pj_tags = var.pj_tags

  rds = {
    prefix           = "app"
    subnet_group_ids = [for k, v in module.network-templates.subnet_pri_ids : v] #["subnet-xxx", "subnet-yyy"]

    security_group_ids    = [module.mariadb-sg.sg_id]
    rds_instance_class    = "db.t4g.micro"
    rds_allocated_storage = 20
    db_engine             = "mysql"
    db_engine_version     = "8.0"
    db_name               = "fuga"
    db_username           = var.rds_username
    db_password           = var.rds_password
    az                    = "a"
    is_multi_az           = false
    is_ops                = false
  }
}

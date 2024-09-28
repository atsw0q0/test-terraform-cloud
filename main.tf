resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_prefix.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = format("%s-%s-vpc-%s-%02d", var.pj_tags.name, var.pj_tags.env, var.vpc_prefix.prefix, 1)
    PJ   = var.pj_tags.name
    Env  = var.pj_tags.env
    TRAIN = "CHUOLINE"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    # Name = format("%s-%s-vpc-%s-%02d", var.pj_tags.name, var.pj_tags.env, each.key, index(local.vpc_count, each.key))
    Name = format("%s-%s-igw-%s-%02d", var.pj_tags.name, var.pj_tags.env, var.vpc_prefix.prefix, 1)
    PJ   = var.pj_tags.name
    Env  = var.pj_tags.env
    TRAIN = "CHUOLINE"
  }
}

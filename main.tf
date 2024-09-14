resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_prefix.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = format("%s-%s-vpc-%s-%02d", var.pj_tags.name, var.pj_tags.env, var.vpc_prefix.prefix, 1)
    PJ   = var.pj_tags.name
    Env  = var.pj_tags.env
  }
}
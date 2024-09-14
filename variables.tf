variable "tfc_aws_dynamic_credentials" {
  description = "Object containing AWS dynamic credentials configuration"
  type = object({
    default = object({
      shared_config_file = string
    })
    aliases = map(object({
      shared_config_file = string
    }))
  })
}

variable "pj_tags" {
  type = object({
    name = string
    env  = string
  })
  default = {
    name = "hoge"
    env  = "test"
  }
}

variable "vpc_prefix" {
  type = object({
    prefix     = string
    cidr_block = string
  })
  default = {
    prefix     = "network"
    cidr_block = "10.0.0.0/16"
  }
}
variable "pj_tags" {
  type = object({
    name = string
    env  = string
  })
  default = {
    name = "foo"
    env  = "test"
  }
}

variable "rds_password" {
  type = string
}

variable "rds_username" {
  type = string
}

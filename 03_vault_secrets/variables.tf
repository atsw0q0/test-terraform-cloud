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

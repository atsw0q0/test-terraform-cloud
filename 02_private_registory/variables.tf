variable "pj_tags" {
  type = object({
    name = string
    env  = string
  })
  default = {
    name = "fuga"
    env  = "test"
  }
}

# variable "tfc_aws_dynamic_credentials" {
#   description = "Object containing AWS dynamic credentials configuration"
#   type = object({
#     default = object({
#       shared_config_file = string
#     })
#     aliases = map(object({
#       shared_config_file = string
#     }))
#   })
# }

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

# variable "subnet" {
#     type = optional(map(object({ 
#         prefix = string
#         cidr_block = string
#         az = string
#         is_public_subnet = bool
#     })))
#     default = {
#         pub_a = {
#             prefix = "pub"
#             cidr_block = "10.0.0.0/24"
#             az = "a"
#             is_public_subnet = true
#         }
#         pub_c = {
#             prefix = "pub"
#             cidr_block = "10.0.1.0/24"
#             az = "c"
#             is_public_subnet = true
#         }
#         pri_a = {
#             prefix = "pri"
#             cidr_block = "10.0.10.0/24"
#             az = "a"
#             is_public_subnet = false
#         }
#         pri_c = {
#             prefix = "pri"
#             cidr_block = "10.0.11.0/24"
#             az = "c"
#             is_public_subnet = false
#         }
#     }
# }
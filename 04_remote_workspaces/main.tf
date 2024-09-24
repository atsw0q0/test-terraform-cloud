data "tfe_outputs" "vpc" {
  organization = "atsuw0w-test-terraform"
  workspace    = "test-terraform-cloud-private-registory"
}

# data "terraform_remote_state" "vpc" {
#   backend = "remote"
#   config = {
#     organization = "atsuw0w-test-terraform"
#     workspaces = {
#       name    = "test-terraform-cloud-private-registory"
#     }
#    }
# }


module "ec2_instance" {
  source  = "app.terraform.io/atsuw0w-test-terraform/webapp-templates/aws//modules/ec2_instance"
  version = "1.0.1-aplha1"

  pj_tags = var.pj_tags

  ec2 = {
    prefix        = "webapp"
    instance_type = "t4g.micro"
    subnet_id     = data.tfe_outputs.vpc.nonsensitive_values.network-templates_values.subnet_pub_ids.pub_a
    vpc_security_group_ids = [
      data.tfe_outputs.vpc.nonsensitive_values.ec2-sg_values.sg_id
    ]
    is_pubic = true
  }
}

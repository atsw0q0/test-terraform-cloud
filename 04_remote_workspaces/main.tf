data "tfe_outputs" "vpc" {
  organization = "atsuw0w-test-terraform"
  workspace    = "test-terraform-cloud-private-registory"
}


module "ec2_instance" {
  source  = "app.terraform.io/atsuw0w-test-terraform/webapp-templates/aws//modules/ec2_instance"
  version = "1.0.1-aplha"

  pj_tags = var.pj_tags

  ec2 = {
    prefix        = "webapp"
    instance_type = "t4g.micro"
    subnet_id     = data.tfe_outputs.vpc.values.network-templates_values.subnet_pub_ids.pub_a
    vpc_security_group_ids = [
      data.tfe_outputs.vpc.values.ec2-sg_values.sg_id
    ]
    is_pubic = true
  }
}

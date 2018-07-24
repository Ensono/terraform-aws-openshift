## Must create service-principal ahead of time
resource "aws_cloudformation_stack" "network" {
  name = "networking-stack"

  parameters {
    AvailabilityZones  = "${var.AvailabilityZones}"
    KeyPairName        = "${var.KeyPairName}"
    NumberOfAZs        = "3"
    PrivateSubnet1CIDR = "${var.PrivateSubnet1CIDR}"
    PrivateSubnet2CIDR = "${var.PrivateSubnet2CIDR}"
    PrivateSubnet3CIDR = "${var.PrivateSubnet3CIDR}"
    PublicSubnet1CIDR  = "${var.PublicSubnet1CIDR}"
    PublicSubnet2CIDR  = "${var.PublicSubnet2CIDR}"
    PublicSubnet3CIDR  = "${var.PublicSubnet3CIDR}"
    VPCCIDR            = "${var.VPCCIDR}"
  }

  on_failure   = "DELETE"
  template_url = "https://${QSS3BucketName}.s3.amazonaws.com/${QSS3KeyPrefix}submodules/quickstart-aws-vpc/templates/aws-vpc.template"

  timeouts {
    create = "2h"
    delete = "2h"
  }
}

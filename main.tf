## Must create service-principal ahead of time

# Configure the AWS Provider
provider "aws" {
  # Export to environment vars!

  #  $ export AWS_ACCESS_KEY_ID="anaccesskey"

  #  $ export AWS_SECRET_ACCESS_KEY="asecretkey"

  #  $ export AWS_DEFAULT_REGION="us-east-2"

  #  $ terraform plan

  #access_key = "${var.aws_access_key}"
  #secret_key = "${var.aws_secret_key}"
  region = "us-east-2"
}

resource "aws_cloudformation_stack" "openshiftnetwork" {
  name = "openshiftnetwork-stack"

  parameters {
    AvailabilityZones   = "${join(",", var.AvailabilityZones)}"
    KeyPairName         = "${var.KeyPairName}"
    NumberOfAZs         = "3"
    PrivateSubnet1ACIDR = "${var.PrivateSubnet1ACIDR}"
    PrivateSubnet2ACIDR = "${var.PrivateSubnet2ACIDR}"
    PrivateSubnet3ACIDR = "${var.PrivateSubnet3ACIDR}"
    PublicSubnet1CIDR   = "${var.PublicSubnet1CIDR}"
    PublicSubnet2CIDR   = "${var.PublicSubnet2CIDR}"
    PublicSubnet3CIDR   = "${var.PublicSubnet3CIDR}"
    VPCCIDR             = "${var.VPCCIDR}"
  }

  on_failure   = "DELETE"
  template_url = "https://github.com/amido/terraform-aws-openshift/blob/master/source/aws-vpc.template"

  # template_url = "https://${var.QSS3BucketName}.s3.amazonaws.com/${var.QSS3KeyPrefix}submodules/quickstart-aws-vpc/templates/aws-vpc.template"

  timeouts {
    create = "2h"
    delete = "2h"
  }
}

resource "aws_cloudformation_stack" "openshift" {
  name = "openshift-stack"

  parameters {
    MasterInstanceType                = "${var.MasterInstanceType}"
    NodesInstanceType                 = "${var.NodesInstanceType}"
    EtcdInstanceType                  = "${var.EtcdInstanceType}"
    NumberOfMaster                    = "${var.NumberOfMaster}"
    NumberOfEtcd                      = "${var.NumberOfEtcd}"
    NumberOfNodes                     = "${var.NumberOfNodes}"
    KeyPairName                       = "${var.KeyPairName}"
    PrivateSubnet1ID                  = "${aws_cloudformation_stack.openshiftnetwork.outputs["PrivateSubnet1AID"]}"
    PrivateSubnet2ID                  = "${aws_cloudformation_stack.openshiftnetwork.outputs["PrivateSubnet2AID"]}"
    PrivateSubnet3ID                  = "${aws_cloudformation_stack.openshiftnetwork.outputs["PrivateSubnet3AID"]}"
    PublicSubnet1ID                   = "${aws_cloudformation_stack.openshiftnetwork.outputs["PublicSubnet3ID"]}"
    PublicSubnet2ID                   = "${aws_cloudformation_stack.openshiftnetwork.outputs["PublicSubnet3ID"]}"
    PublicSubnet3ID                   = "${aws_cloudformation_stack.openshiftnetwork.outputs["PublicSubnet3ID"]}"
    RemoteAccessCIDR                  = "${var.RemoteAccessCIDR}"
    ContainerAccessCIDR               = "${var.RemoteAccessCIDR}"
    QSS3BucketName                    = "${var.QSS3BucketName}"
    QSS3KeyPrefix                     = "${var.QSS3KeyPrefix}"
    OpenShiftAdminPassword            = "${var.OpenShiftAdminPassword}"
    RedhatSubscriptionUserName        = "${var.RedhatSubscriptionUserName}"
    RedhatSubscriptionPassword        = "${var.RedhatSubscriptionPassword}"
    RedhatSubscriptionPoolID          = "${var.RedhatSubscriptionPoolID}"
    OutputBucketName                  = "${var.OutputBucketName}"
    VPCCIDR                           = "${var.VPCCIDR}"
    VPCID                             = "${aws_cloudformation_stack.openshiftnetwork.outputs["VPCID"]}"
    OpenshiftContainerPlatformVersion = "${var.OpenshiftContainerPlatformVersion}"
    AWSServiceBroker                  = "${var.AWSServiceBroker}"
    ExistingAWSServiceBrokerRole      = "${var.ExistingAWSServiceBrokerRole}"
    HostedZoneID                      = "${var.HostedZoneID}"
    DomainName                        = "${var.DomainName}"
    SubDomainPrefix                   = "${var.SubDomainPrefix}"
    HawkularMetrics                   = "${var.HawkularMetrics}"
    ClusterName                       = "openshift-stack"
  }

  # on_failure   = "DELETE"
  template_url = "https://github.com/amido/terraform-aws-openshift/blob/master/source/openshift.template"

  # template_url = "https://${var.QSS3BucketName}.s3.amazonaws.com/${var.QSS3KeyPrefix}templates/openshift.template"
  capabilities     = ["CAPABILITY_IAM"]
  disable_rollback = true

  timeouts {
    create = "2h"
    delete = "2h"
  }
}

variable KeyPairName {
  # TODO find a way of making this dynamic.
  default     = "terraformOS"                                                                                                              #
  description = "The name of an existing public/private key pair, which allows you to securely connect to your instance after it launches"
}

# InstanceTypes:
#  AllowedValues:
#    - t2.large
#    - m4.xlarge
#    - m4.2xlarge
#    - m4.4xlarge
#    - m4.10xlarge
#    - c4.large
#    - c4.xlarge
#    - c4.2xlarge
#    - c4.4xlarge
#    - c4.8xlarge

variable MasterInstanceType {
  default     = "t2.large"
  description = "Type of EC2 instance for the Master instances."
}

variable NumberOfMaster {
  default     = "3"
  description = "This Deployment requires 3 OpenShift Master instances"
}

variable EtcdInstanceType {
  default     = "t2.large"
  description = "Type of EC2 instance for the Master instances."
}

variable NumberOfEtcd {
  default     = "3"
  description = "This Deployment requires 3 OpenShift etcd instances"
}

variable NodesInstanceType {
  default     = "t2.large"
  description = "Type of EC2 instance for the Master instances."
}

variable NumberOfNodes {
  default     = "3"
  description = "The desired capacity of Node instances"
}

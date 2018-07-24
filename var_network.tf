variable "AvailabilityZones" {
  type        = "list"
  default     = ["us-east-2a", "us-east-2b", "us-east-2c"]
  description = "List of Availability Zones to use for the subnets in the VPC."
}

variable "VPCCIDR" {
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}

variable "PrivateSubnet1ACIDR" {
  default     = "10.0.0.0/19"
  description = "CIDR block for private subnet 1 located in Availability Zone 1. CIDR block parameter must be in the form x.x.x.x/16-28"
}

variable "PrivateSubnet2ACIDR" {
  default     = "10.0.32.0/19"
  description = "CIDR block for private subnet 2 located in Availability Zone 2. CIDR block parameter must be in the form x.x.x.x/16-28"
}

variable "PrivateSubnet3ACIDR" {
  default     = "10.0.64.0/19"
  description = "CIDR block for private subnet 3 located in Availability Zone 3. CIDR block parameter must be in the form x.x.x.x/16-28"
}

variable "PublicSubnet1CIDR" {
  default     = "10.0.128.0/20"
  description = "CIDR block for private subnet 1 located in Availability Zone 1. CIDR block parameter must be in the form x.x.x.x/16-28"
}

variable "PublicSubnet2CIDR" {
  default     = "10.0.144.0/20"
  description = "CIDR block for public (DMZ) subnet 2 located in Availability Zone 2. CIDR block parameter must be in the form x.x.x.x/16-28"
}

variable "PublicSubnet3CIDR" {
  default     = "10.0.160.0/20"
  description = "CIDR block for public (DMZ) subnet 3 located in Availability Zone 3. CIDR block parameter must be in the form x.x.x.x/16-28"
}

variable "RemoteAccessCIDR" {
  # TODO expose this differently!
  default     = "80.87.29.208/32"
  description = "The CIDR IP range that is permitted to access the instances We recommend that you set this value to a trusted IP range. CIDR block parameter must be in the form x.x.x.x/x"
}

variable "ContainerAccessCIDR" {
  # TODO expose this differently!  
  default     = "80.87.29.208/32"
  description = "The CIDR IP range that is permitted to access the instances We recommend that you set this value to a trusted IP range. CIDR block parameter must be in the form x.x.x.x/x"
}

variable "DomainName" {
  default     = ""
  description = "DPTIONAL: domain name configured for the cluster, if left blank self signed certificates will be used for TLS and the LoadBalancer's auto-generated hostname will be used for connections from outside the cluster."
}

variable "HostedZoneID" {
  default     = ""
  description = "OPTIONAL: Route 53 Hosted Zone ID to use. If left blank route 53 will not be configured and DNS must be setup manually If you specify this you must also specify DomainName'"
}

variable "SubDomainPrefix" {
  default     = ""
  description = "OPTIONAL: Subdomain to use, if left blank DomainName will be used without a prefix. If you specify this you must also specify DomainName and HostedZoneID"
}

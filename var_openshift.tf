variable ExistingAWSServiceBrokerRole {
  default     = ""
  description = "OPTIONAL: Existing service role ARN for the AWS Service Broker. If left blank a role with AdministratorAccess will be created"
}

variable HawkularMetrics {
  default     = true
  description = "Enable Hawkular cluster metrics"
}

variable OpenshiftContainerPlatformVersion {
  default     = "3.7"
  description = "OpenShift version to deploy. Can be 3.7 or 3.9"
}

variable OpenShiftAdminPassword {
  default     = ""
  description = "TPassword for OpenShift Admin UI Must be 8-12 characters containing letters and (minimum 1 capital letter), numbers and symbols"
}

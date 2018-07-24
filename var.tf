variable OutputBucketName {
  default     = ""
  description = "Where Zip file will be placed"
}

variable QSS3BucketName {
  default     = "aws-quickstart"
  description = "Where templates are located"
}

variable QSS3KeyPrefix {
  default     = "quickstart-redhat-openshift/"
  description = "Where linked templates are located"
}

#variable aws_secret_key {}
#variable aws_access_key {}


            #!/bin/bash -x
            export QSLOCATION=https://${QSS3BucketName}.${S3Region}.amazonaws.com/${QSS3KeyPrefix}
            export ENABLE_HAWKULAR=${HawkEnable}
            export OCP_ANSIBLE_RELEASE=${OsbRelease}
            export AWSSB_ROLE=${AwsSbRole}
            export MASTER_ELBDNSNAME=${LbHostname}
            export INTERNAL_MASTER_ELBDNSNAME=${OpenShiftMasterInternalELB.DNSName}
            export OPENSHIFTMASTERINTERNALELB=${OpenShiftMasterInternalELB}
            export OPENSHIFTMASTERINTERNALTGARN=${OpenShiftMasterInternalELBTargetGroup}
            export AWS_REGION=${AWS::Region}
            export CONTAINERACCESSELB=${ContainerAccessELB}
            export OCP_VERSION=${OpenshiftContainerPlatformVersion}
            export RH_USER=${RedhatSubscriptionUserName}
            export RH_PASS='${RedhatSubscriptionPassword}'
            export RH_POOLID=${RedhatSubscriptionPoolID}
            export AWS_STACKNAME=${AWS::StackName}
            export QS_S3URI=s3://${QSS3BucketName}/${QSS3KeyPrefix}
            export OCP_PASS='${OpenShiftAdminPassword}'
            export AWS_STACKID=${AWS::StackId}
            export ENABLE_AWSSB=${AWSServiceBroker}
            export VPCID=${VPCID}
            yum install -y git
            git clone https://github.com/aws-quickstart/quickstart-linux-utilities.git
            export P=/quickstart-linux-utilities/quickstart-cfn-tools.source
            source $P
            qs_bootstrap_pip || qs_err " pip bootstrap failed "
            qs_aws-cfn-bootstrap || qs_err "cfn bootstrap failed"
            pip install awscli  &> /var/log/userdata.awscli_install.log || qs_err " awscli install failed "
            aws s3 cp ${!QS_S3URI}scripts/ansibleconfigserver_bootstrap.sh ./bootstrap.sh
            chmod +x bootstrap.sh
            ./bootstrap.sh || qs_err " Openshift installation failed, see logs for details "
            cfn-signal -e $(qs_status) --stack ${AWS::StackName} --resource AnsibleConfigServer --region ${AWS::Region}
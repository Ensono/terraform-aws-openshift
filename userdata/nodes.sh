            #!/bin/bash -x
            QSLOCATION=https://${QSS3BucketName}.${S3Region}.amazonaws.com/${QSS3KeyPrefix}
            yum install -y git
            git clone https://github.com/aws-quickstart/quickstart-linux-utilities.git
            export P=/quickstart-linux-utilities/quickstart-cfn-tools.source
            source $P
            qs_bootstrap_pip || qs_err " pip bootstrap failed "
            qs_aws-cfn-bootstrap || qs_err " cfn bootstrap failed "
            pip install awscli  &> /var/log/userdata.awscli_install.log || qs_err " awscli install failed "
            export QS_S3URI=s3://${QSS3BucketName}/${QSS3KeyPrefix}
            export AWS_REGION=${AWS::Region}
            export AWS_STACKNAME=${AWS::StackName}
            export RH_POOLID=${RedhatSubscriptionPoolID}
            export RH_USER=${RedhatSubscriptionUserName}
            export RH_PASS='${RedhatSubscriptionPassword}'
            export OCP_VERSION=${OpenshiftContainerPlatformVersion}
            export LAUNCH_CONFIG=OpenShiftNodesLaunchConfig
            aws s3 cp ${!QS_S3URI}scripts/bootstrap.sh ./bootstrap.sh
            chmod +x bootstrap.sh
            ./bootstrap.sh || qs_err " bootstrapping failed, see logs for details "
            cfn-signal -e $(qs_status) --stack ${AWS::StackName} --resource OpenShiftNodeASG --region ${AWS::Region}
resource "aws_sns_topic" "alarm_sns" {
  name = "tf-${var.service_instance_name}-sns"

  policy = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish",
        "SNS:Receive"
      ],
      "Resource": "arn:aws:sns:eu-west-3:899415655760:notice",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "899415655760"
        }
      }
    }
  ]
}
EOF

  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "numRetries": 3,
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF

  tags = {
    Name = var.service_instance_name
    ServiceName = var.service_name
    Environment = var.environment_name
    Description = "Alarm notificatons for ${var.service_instance_name}"
  }
}

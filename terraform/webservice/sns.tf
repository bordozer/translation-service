resource "aws_sns_topic" "cpu_usage_is_very_high_sns_topic" {
//  name = "Alarm! ${var.service_instance_name} CPU ussage is very high"
  name = "tf-${var.service_instance_name}-sns-topic"

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

  provisioner "local-exec" {
    command = "sh ./files/sns_subscription.sh"
    environment = {
      sns_arn = self.arn
      sns_emails = var.alarm_notification_emails
    }
  }

  tags = {
    Name = var.service_instance_name
    ServiceName = var.service_name
    Environment = var.environment_name
    Description = "Alarm notificatons for ${var.service_instance_name}"
  }
}

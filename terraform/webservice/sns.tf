// TODO: the issue: nesseccity to confirm email each time after topic creation
resource "aws_sns_topic" "cpu_usage_is_very_high_sns_topic" {
  name = "tf-${var.service_instance_name}-cpu-is-too-high-sns-topic"

  provisioner "local-exec" {
    command = "sh ./files/sns_subscription.sh"
    environment = {
      sns_arn = self.arn
      sns_emails = var.alarm_notification_emails
    }
  }

  tags = local.common_tags
}

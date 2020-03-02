resource "aws_cloudwatch_metric_alarm" "cpu_usage_is_very_high" {
  alarm_name = "tf-${var.service_instance_name}-CPU-too-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 3 # The number of periods over which data is compared to the specified threshold.
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 60 # The period in seconds over which the specified statistic is applied
  statistic = "Average"
  threshold = 80 # The value against which the specified statistic is compared
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.service_asg.name
  }
  alarm_description = "Add instance if CPU Utilization is too high"
  alarm_actions = [
    aws_autoscaling_policy.add_instance_policy.arn
  ]
}

resource "aws_autoscaling_policy" "add_instance_policy" {
  name = "tf-${var.service_instance_name}-asg-add-instance-policy"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 10 # The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start
  autoscaling_group_name = aws_autoscaling_group.service_asg.name
  policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu_usage_is_very_low" {
  alarm_name = "tf-${var.service_instance_name}-CPU-is-too-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 60
  statistic = "Average"
  threshold = 40
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.service_asg.name
  }
  alarm_description = "Remove instance if CPU Utilization is too low"
  alarm_actions = [
    aws_autoscaling_policy.remove_instance_policy.arn
  ]
}

resource "aws_autoscaling_policy" "remove_instance_policy" {
  name = "tf-${var.service_instance_name}-asg-remove-instance-policy"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 10
  autoscaling_group_name = aws_autoscaling_group.service_asg.name
  policy_type = "SimpleScaling"
}

# https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html

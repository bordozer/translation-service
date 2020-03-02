resource "aws_autoscaling_policy" "heavy_out" {
  name = "tf-${var.service_instance_name}-asg-add-policy"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 10
  autoscaling_group_name = aws_autoscaling_group.service_asg.name
}

resource "aws_autoscaling_policy" "heavy-in" {
  name = "tf-${var.service_instance_name}-asg-remove-policy"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 10
  autoscaling_group_name = aws_autoscaling_group.service_asg.name
}

resource "aws_cloudwatch_metric_alarm" "heavy_asg_cpu_usage_is_very_high" {
  alarm_name = "heavy-asg-cpu-usage-is-very-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 60
  statistic = "Average"
  threshold = 80
  dimensions {
    AutoScalingGroupName = aws_autoscaling_group.service_asg.name
  }
  alarm_description = "This metric monitors EC2 CPU utilization"
  alarm_actions = [
    aws_autoscaling_policy.heavy_out.arn]
}

resource "aws_cloudwatch_metric_alarm" "heavy_asg_cpu_usage_is_very_low" {
  alarm_name = "heavy-asg-cpu-usage-is-very-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 60
  statistic = "Average"
  threshold = 40
  dimensions {
    AutoScalingGroupName = aws_autoscaling_group.service_asg.name
  }
  alarm_description = "This metric monitors EC2 CPU utilization"
  alarm_actions = [
    aws_autoscaling_policy.heavy-in.arn]
}

locals {
  keys = ["foo", "bar", "baz"]
}
resource "aws_cloudwatch_metric_alarm" "custom_alarms" {

  for_each   = toset(local.keys)
  alarm_name = "${module.context.id}-custom-${each.value}-alarm"

  alarm_description   = "Custom alarm on any log"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ErrorCount"
  namespace           = "LogMetrics"
  period              = "60" # seconds
  statistic           = "Sum"
  threshold           = "1" # percent
  dimensions = {
    "LogGroupName" = aws_cloudwatch_log_group.log_groups[each.key].name
  }
  actions_enabled                       = false
  alarm_actions                         = []
  datapoints_to_alarm                   = null
  evaluate_low_sample_count_percentiles = null
  extended_statistic                    = null
  insufficient_data_actions             = []
  ok_actions                            = []
  threshold_metric_id                   = null
  treat_missing_data                    = null
  unit                                  = null
}

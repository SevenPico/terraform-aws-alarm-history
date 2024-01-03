module "alarm_history_pattern_example" {
  source              = "../../"
  alarm_names         = aws_cloudwatch_metric_alarm.custom_alarms[count.index].alarm_name
  metric_namespace    = "example-costa-poc"
  metric_service_name = "example-connectors-alarm-history"
}
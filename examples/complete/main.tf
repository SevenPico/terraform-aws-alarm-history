module "alarm_history_pattern_example" {
  source              = "../../"
  context             = module.context.self
  alarm_names         = [for alarm in aws_cloudwatch_metric_alarm.custom_alarms : alarm.alarm_name]
  metric_namespace    = "example-namespace"
  metric_service_name = "example-service"
}
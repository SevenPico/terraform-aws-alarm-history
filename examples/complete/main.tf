locals {
  metric_config = {
    namespace    = "example-namespace"
    service_name = "example-service"
  }
}

module "alarm_history_pattern_example" {
  source              = "../../"
  context             = module.context.self
  alarm_names         = [for alarm in aws_cloudwatch_metric_alarm.custom_alarms : alarm.alarm_name]
  metric_namespace    = local.metric_config.namespace
  metric_service_name = local.metric_config.service_name
}
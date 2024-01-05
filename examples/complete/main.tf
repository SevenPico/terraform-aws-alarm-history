module "alarm_history_pattern_example" {
  source              = "../../"
  alarm_names         = local.alarm_names
  metric_namespace    = "example-costa-poc"
  metric_service_name = "example-connectors-alarm-history"
}
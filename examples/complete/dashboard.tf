locals {
  metric_name  = "Alarm State"
  light_colors = ["#ff7979", "#87CEFA", "#97a397", "#ffa07a", "#f9e886", "#b0fafa", "#d8fba4", "#f8aff4"]
  dark_colors  = ["#db041d", "#0c79e6", "#015101", "#e45f2e", "#dfa104", "#06b3b6", "#62c203", "#c50e97"]

  metrics_data_point = [
    for i, alarm in aws_cloudwatch_metric_alarm.custom_alarms :
    [
      var.metric_namespace,
      local.metric_name,

      "service",
      var.metric_service_name,

      "Alarm Name",
      alarm.alarm_name,

      {
        id : "m${i}",
        region : var.region,
        color : local.dark_colors[i]
      }
    ]
  ]

  metrics_data_fill = [
    for i, alarm in aws_cloudwatch_metric_alarm.custom_alarms :
    [
      {
        expression : "FILL(m${i}, REPEAT)",
        label : "FILL: ${alarm.alarm_name}"
        id : "e${i}"
        region : var.region
        period : 10
        color : local.light_colors[i]
      }
    ]
  ]


  /**
 * [m0, m1, m2] + [e0, e1, e2]
 * => [[m0, e0], [m1, e1], [m2, e2]]
 * => [ m0, e0,   m1, e1,   m2, e2 ]
 */
  metrics_combined = flatten([
    for pair in setproduct(local.metrics_data_point, local.metrics_data_fill) : pair
  ])
}

module "dashboard" {
  source               = "SevenPico/health/aws"
  version              = "0.1.1"
  context              = module.context.self
  notify_sns_topic_arn = ""

  cloudwatch_alarm_groups = [
    {
      title      = "Current Alarm State"
      alarm_arns = [for alarm in aws_cloudwatch_metric_alarm.custom_alarms : alarm.arn]
      height     = 6
      width      = 6
    }
  ]

  additional_widgets = [
    {
      type       = "metric"
      height     = 6
      width      = 18
      properties = {
        metrics = local.metrics_combined
        period  = 300
        region  = local.region
        title   = "Alarm History"
        view    = "timeSeries"
      }
      updateOn = {
        refresh   = true
        resize    = true
        timeRange = true
      }
    }
  ]
}


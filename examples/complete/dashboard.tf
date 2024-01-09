locals {
  metric_name  = "Alarm State"
  light_colors = ["#ff7979", "#87CEFA", "#97a397", "#ffa07a", "#f9e886", "#b0fafa", "#d8fba4", "#f8aff4"]
  dark_colors  = ["#db041d", "#0c79e6", "#015101", "#e45f2e", "#dfa104", "#06b3b6", "#62c203", "#c50e97"]

  alarm_names = keys(aws_cloudwatch_metric_alarm.custom_alarms)
  metrics_data_point = [
    for i, alarm_key in local.alarm_names :
    [
      var.metric_namespace,
      local.metric_name,

      "service",
      var.metric_service_name,

      "Alarm Name",
      aws_cloudwatch_metric_alarm.custom_alarms[alarm_key].alarm_name,

      {
        id : "m${i}",
        region : var.region,
        color : local.dark_colors[i]
      }
    ]
  ]

  metrics_data_fill = [
    for i, alarm_key in local.alarm_names :
    [
      {
        expression : "FILL(m${i}, REPEAT)",
        label : "FILL: ${aws_cloudwatch_metric_alarm.custom_alarms[alarm_key].alarm_name}"
        id : "e${i}"
        region : var.region
        period : 10
        color : local.light_colors[i]
      }
    ]
  ]

  #  metrics_combined = concat(local.metrics_data_point, local.metrics_data_fill)
  metrics_combined = [
    for i in range(length(local.metrics_data_point) * 2) :
    [local.metrics_data_point[floor(i / 2)], local.metrics_data_fill[floor(i / 2)]][i % 2 == 0 ? 0 : 1]
  ]
}

module "alarm_history_dashboard" {
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
      stacked    = true
    }
  ]

  additional_widgets = [
    {
      type   = "metric"
      height = 6
      width  = 18
      properties = {
        metrics = local.metrics_combined
        period  = 10
        stat    = "Maximum"
        region  = local.region
        title   = "Alarm History"
        view    = "timeSeries"
        stacked = true,
        legend = {
          position = "right"
        }
        yAxis = {
          right = {
            showUnits = false
          },
          left = {
            showUnits = false,
            min       = 0,
            max       = 1
          }
        },
        annotations = {
          horizontal = [
            {
              label = "1 is ALARM, 0 is OK",
              value = 0.5
            }
          ]
        },
        liveData = true
      }
      updateOn = {
        refresh   = true
        resize    = true
        timeRange = true
      }
    }
  ]
}


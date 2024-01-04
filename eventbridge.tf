#------------------------------------------------------------------------------
# EventBridge Rule
#------------------------------------------------------------------------------

resource "aws_cloudwatch_event_rule" "event_rule" {
  count       = module.context.enabled ? 1 : 0
  name        = "capture-alarm-history"
  description = "Capture alarm states"

  event_pattern = jsonencode({
    "detail" : {
      "alarmName" : var.alarm_names,
      "state" : {
        "value" : ["ALARM", "OK"]
      }
    }
  })
}

resource "aws_cloudwatch_event_target" "lambda" {
  count = module.context.enabled ? 1 : 0
  rule  = aws_cloudwatch_event_rule.event_rule[0].name
  arn   = module.lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  count         = module.context.enabled ? 1 : 0
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.event_rule[0].arn
}

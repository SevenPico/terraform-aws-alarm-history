# Aws Alarm History Module
This Example integrates Alarm History Module with actual alarms. This module will create a dashboard of the time series alarm state. 
Whenever the alarm state will change, the dashboard will reflect the metric with the history of that alarm.

This example module will publish following alarms. 
- `brim-alarm-history-complete-custom-foo-alarm`
- `brim-alarm-history-complete-custom-bar-alarm`
- `brim-alarm-history-complete-custom-baz-alarm`

#### Change Alarm state to ALARM
Change the all 3 alarm state to ALARM and then to OK, and observe `AlarmStateToMetric` Lambda logs to check the metric publish history.

```commandline
aws cloudwatch set-alarm-state --alarm-name brim-alarm-history-complete-custom-foo-alarm --state-value ALARM --state-reason Testing
aws cloudwatch set-alarm-state --alarm-name brim-alarm-history-complete-custom-bar-alarm --state-value ALARM --state-reason Testing
aws cloudwatch set-alarm-state --alarm-name brim-alarm-history-complete-custom-baz-alarm --state-value ALARM --state-reason Testing
```

#### Change Alarm state to OK
```commandline
aws cloudwatch set-alarm-state --alarm-name brim-alarm-history-complete-custom-foo-alarm --state-value OK --state-reason Testing
aws cloudwatch set-alarm-state --alarm-name brim-alarm-history-complete-custom-bar-alarm --state-value OK --state-reason Testing
aws cloudwatch set-alarm-state --alarm-name brim-alarm-history-complete-custom-baz-alarm --state-value OK --state-reason Testing
```

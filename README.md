# Aws Alarm History Module
This module allows us to put the time series history of any alarm on a Dashboard. Multiple Alarms of the same time for different Resources can be rendered on the same Line Chart.

This module is a Data provider, which deploys the following 
 - Event bridge configurations for alarms
 - A Lambda to generate the High resolution metrics per alarm

> **[TBD]** Dashboard will be available as a separate monitoring module soon.  
 
variable "metric_namespace" {
  type        = string
  default     = ""
  description = "Namespace for the Alarm state history metric"
}

variable "metric_service_name" {
  type        = string
  default     = ""
  description = "The service name for the Alarm state history metric"
}

variable "alarm_names" {
  type        = list(string)
  default     = []
  description = "List of alarm names for generating their state history metric"
}
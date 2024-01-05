#------------------------------------------------------------------------------
# Inputs
#------------------------------------------------------------------------------

variable "metric_namespace" {
  type        = string
  default     = "poc"
  description = "Namespace for the Alarm state history metric"
}

variable "metric_service_name" {
  type        = string
  default     = "service"
  description = "The service name for the Alarm state history metric"
}
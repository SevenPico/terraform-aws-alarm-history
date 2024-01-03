#------------------------------------------------------------------------------
# EC2 Inputs
#------------------------------------------------------------------------------
variable "ec2_associate_public_ip_address" {
  type    = bool
  default = true
}

variable "ec2_ami_id" {
  type    = string
  default = "ami-0574da719dca65348"
}

variable "ec2_autoscale_desired_count" {
  type    = number
  default = 1
}

variable "ec2_autoscale_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ec2_autoscale_max_count" {
  type    = number
  default = 1
}

variable "ec2_autoscale_min_count" {
  type    = number
  default = 1
}

variable "ec2_autoscale_sns_topic_default_result" {
  type    = string
  default = "CONTINUE"
}

variable "ec2_autoscale_sns_topic_heartbeat_timeout" {
  type    = number
  default = 180
}

variable "ec2_additional_security_group_ids" {
  type    = list(string)
  default = []
}

variable "ec2_disable_api_termination" {
  type        = bool
  description = "If `true`, enables EC2 Instance Termination Protection"
  default     = false
}

variable "ec2_role_source_policy_documents" {
  type        = list(string)
  default     = []
  description = "If necessary, provide additional JSON Policy Documents for the EC2 Instance."
}

variable "ec2_upgrade_schedule_expression" {
  type    = string
  default = "cron(15 13 ? * SUN *)"
}

variable "ec2_security_group_allow_all_egress" {
  type    = bool
  default = true
}

variable "ec2_security_group_rules" {
  type    = list(any)
  default = []
}

variable "ec2_block_device_mappings" {
  description = "Specify volumes to attach to the instance besides the volumes specified by the AMI"
  type = list(object({
    device_name  = string
    no_device    = bool
    virtual_name = string
    ebs = object({
      delete_on_termination = bool
      encrypted             = bool
      iops                  = number
      kms_key_id            = string
      snapshot_id           = string
      volume_size           = number
      volume_type           = string
    })
  }))

  default = []
}
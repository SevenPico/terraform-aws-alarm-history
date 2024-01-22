

resource "aws_cloudwatch_log_group" "log_groups" {
  #checkov:skip=CKV_AWS_158:skipping 'Ensure that CloudWatch Log Group is encrypted by KMS'
  #checkov:skip=CKV_AWS_338:skipping 'Ensure CloudWatch log groups retains logs for at least 1 year'
  #checkov:skip=CKV_AWS_66:skipping 'Ensure that CloudWatch Log Group specifies retention days'
  for_each = module.context.enabled ? toset(local.keys) : []
  name     = "/aws/example/${module.context.id}/${each.value}"
  tags     = module.context.tags
}

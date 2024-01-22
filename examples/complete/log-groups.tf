

resource "aws_cloudwatch_log_group" "log_groups" {
  #checkov:skip=CKV_AWS_158: "Ensure that CloudWatch Log Group is encrypted by KMS"
  for_each = module.context.enabled ? toset(local.keys) : []
  name     = "/aws/example/${module.context.id}/${each.value}"
  tags     = module.context.tags
}

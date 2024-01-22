
#checkov:skip=CKV_AWS_158: "Ensure that CloudWatch Log Group is encrypted by KMS"
resource "aws_cloudwatch_log_group" "log_groups" {
  for_each = module.context.enabled ? toset(local.keys) : []
  name     = "/aws/example/${module.context.id}/${each.value}"
  tags     = module.context.tags
}

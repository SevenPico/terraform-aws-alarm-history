
resource "aws_cloudwatch_log_group" "log_groups" {
  for_each = toset(local.keys)
  name     = "/aws/example/${module.context.id}/${each.value}"
  tags     = module.context.tags
}
# Linking the necessary policy with role 
resource "aws_iam_role_policy_attachment" "attachment_policy" {
 role        = aws_iam_role.lambda.name
 policy_arn  = "arn"
 }

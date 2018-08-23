#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
# IAM Role
resource "aws_iam_role" "${configurationManagementName}" {
  name = "${configurationManagementName}-role"
  description = "${configurationManagementName} IAM Role"
  assume_role_policy = "${symbol_dollar}{file("${symbol_dollar}{path.module}/assume-role-policy.json")}"
}

# Instance Profile
resource "aws_iam_instance_profile" "${configurationManagementName}" {
  name  = "${configurationManagementName}-profile"
  role = "${symbol_dollar}{aws_iam_role.${configurationManagementName}.name}"
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = "${symbol_dollar}{aws_iam_role.${configurationManagementName}.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

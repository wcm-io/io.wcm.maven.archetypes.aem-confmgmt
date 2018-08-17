#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
output "instance_profile_name" {
  value = "${symbol_dollar}{aws_iam_instance_profile.${configurationManagementName}.name}"
}
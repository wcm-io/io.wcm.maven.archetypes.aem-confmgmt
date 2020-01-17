#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
output "security_group_${configurationManagementName}" {
  value = aws_security_group.${configurationManagementName}.name
}

output "security_group_${configurationManagementName}_id" {
  value = aws_security_group.${configurationManagementName}.id
}
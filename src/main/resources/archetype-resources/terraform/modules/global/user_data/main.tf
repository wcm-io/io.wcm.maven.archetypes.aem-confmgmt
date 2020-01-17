#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
output "user_data" {
  value = file("${symbol_dollar}{path.module}/cloud-config.yml")
}

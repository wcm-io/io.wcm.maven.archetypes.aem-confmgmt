#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
output "user_data" {
  value = "${symbol_dollar}{file("${path.module}/cloud-config.yml")}"
}

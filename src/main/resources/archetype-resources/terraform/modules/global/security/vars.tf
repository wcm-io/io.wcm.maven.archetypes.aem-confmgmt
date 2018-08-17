variable "cidr_blocks_ingress" {
  type = "list"
  default = [
#foreach( $ip in $accessRestrictionIpAddress.split(",") )
    "$ip",
#end
  ]
}
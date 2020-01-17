variable "cidr_blocks_ingress" {
  type = list(string)
  default = [
#foreach( $ip in $accessRestrictionIpAddress.split(",") )
    "$ip",
#end
  ]
}
resource "aws_security_group" "${configurationManagementName}" {
  name = "${configurationManagementName}"
  description = "${configurationManagementName} security group"

  # --- AWS ALLOW ALL EGRESS ---
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # --- STANDARD PORTS ---
  
  # SSH access
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = var.cidr_blocks_ingress
    self = true
  }

  # Dispatcher access
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = var.cidr_blocks_ingress
    self = true
  }

  # Dispatcher SSL access
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = var.cidr_blocks_ingress
    self = true
  }

  # Author and publisher access
  ingress {
    from_port = 4502
    to_port = 4503
    protocol = "tcp"
    cidr_blocks = var.cidr_blocks_ingress
    self = true
  }
}

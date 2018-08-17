resource "aws_key_pair" "${configurationManagementName}-key" {
  key_name   = "${configurationManagementName}-key"
  public_key = "${sshPublicKeyString}"
}
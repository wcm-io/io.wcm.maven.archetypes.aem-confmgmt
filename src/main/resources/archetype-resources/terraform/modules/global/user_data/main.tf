output "user_data" {
  value = file("${path.module}/cloud-config.yml")
}

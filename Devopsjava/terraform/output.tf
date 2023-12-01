output "InstanceId" {
  value = aws_instance.my_instance.id
}
output "PublicIpAddress" {
  value = aws_instance.my_instance.public_ip
}
output "ec2instance-publicip" {
  value = aws_instance.project-iac.public_ip
}
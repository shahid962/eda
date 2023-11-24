

output "pvtcidrid" {
  value = aws_subnet.pvt_subnet.id
}
output "pubcidrid" {
  value = aws_subnet.pub_subnet.id

}

output "vpcid" {
  value = aws_vpc.vpc.id

}
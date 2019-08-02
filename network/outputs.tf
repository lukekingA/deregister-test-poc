# network/outputs.tf

output "vpc_id" {
  value = "${aws_vpc.test_vpc.id}"
}

output "test_public_rt_id" {
  value = "${aws_route_table.test_vpc_public_rt.id}"
}

output "test_private_rt_id" {
  value = "${aws_default_route_table.test_vpc_private_rt.id}"
}

output "test_subnet_id" {
  value = "${aws_subnet.test_subnet.id}"
}

output "public_rt_assoc_id" {
  value = "${aws_route_table_association.test_public_assoc.id}"
}

output "public_sg_id" {
  value = "${aws_security_group.test_vpn_sg.id}"
}




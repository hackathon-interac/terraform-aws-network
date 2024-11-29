output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "database_subnet_group_name" {
  value = "${aws_db_subnet_group.database.name}"
}

output "private_subnets_cidr_blocks" {
  value = "${aws_subnet.private[*].cidr_block}"
}
output "vpc_id" {
  description = "ID of project VPC"
  value =  aws_vpc.VPC.id
}
output "vpc_cidr_block" {
 value = aws_vpc.example.cidr_block
}

output "app1" {
    value = aws_instance.app1.id
}
output "subnet_id1" {
    value= aws_subnet.sub1.ids
}

output "subnet_id2" {
    value= aws_subnet.sub2.ids
}
output "vpc-id" {
  description = "ID of project VPC"
  value =  aws_vpc.VPC.id
}
output "SG_id" {
    description = "SG__ID"
    value = aws_security_group.example_sg.id
}
output "ALB_arn" {
    value = aws_lb.my_alb.arn
}
output "target_group_arn" {
    value = aws_lb_target_group.my_target_group.arn
}
output "ec2_id" {
    value = aws_instance.app1.id
}
variable "aws_region" {
  description = "AWS region"
  default     = "ap-south-1"
}
 
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "192.21.0.0/16"
}
 
variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  default     = "192.21.0.0/17"
}
 
variable "availability_zone" {
  description = "Availability zone for the subnet"
  default     = "ap-south-1a"
}
 
variable "vpc_name" {
  description = "Name tag for VPC"
  default     = "MyVPC"
}
 
variable "public_subnet_name" {
  description = "Name tag for public subnet"
  default     = "PublicSubnet"
}
 
variable "public_route_table_name" {
  description = "Name tag for public route table"
  default     = "PublicRouteTable"
}
 
variable "security_group_name" {
  description = "Name tag for security group"
  default     = "MySecurityGroup"
}
 
variable "ec2_ami" {
  description = "AMI ID for EC2 instance"
  default     = "ami-12345678"
}
 
variable "ec2_instance_type" {
  description = "Instance type for EC2 instance"
  default     = "t2.micro"
}
 
variable "ec2_instance_name" {
  description = "Name tag for EC2 instance"
  default     = "MyEC2Instance"
}
 
variable "s3_bucket_name" {
  description = "Name for S3 bucket"
  default     = "my-unique-bucket-name"
}

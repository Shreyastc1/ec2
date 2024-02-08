variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-2"
}
variable "cidr_block" {
  type = string
  default= " 10.0.0./16"
}
variable "subnet_cidr_block1" {
  description = "CIDR block for the subnet"
  default = "1o.0.0.0/24"  # Change to your desired subnet CIDR block
}
variable "subnet_cidr_block2" {
  description = "CIDR block for the subnet"
  default = "190.0.1.0/24" 
} 

variable "availability_zone1" {
  description = "Availability zone for the subnet"
  default = "ap-south-2a"  # Change to your desired availability zone
}
variable "availability_zone2" {
  description = "Availability zone for the subnet"
  default = "ap-south-2b"  # Change to your desired availability zone
}
variable "ami_id" {
  description = "AMI ID"
  default = "ami-052f483c20fa1351a"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default = "yes"
}
variable "alb_name" {
  description = "Name for the ALB"
  default = "my-alb"  # Change to your desired ALB name
}
variable "enable_deletion_protection" {
  description = "Enable deletion protection for the ALB"
  type        = bool
  default     = false  # Set to true if you want to enable deletion protection
}


variable "target_group_port" {
    default = 80
}

variable "protocol" {
    default = HTTP
}
variable "listener_port" {
    default = 80
}

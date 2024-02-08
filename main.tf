resource "aws_vpc" "VPC" {
  cidr_block = var.cidr_block

  tags = {
    Name = "VPC1"
  }
}
resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.VPC.id
  cidr_block = var.subnet_cidr_block1
  availability_zone       = var.availability_zone1

  tags = {
    Name = "publicsubnett"
  }
}
resource "aws_subnet" "sub2" {
  vpc_id = aws_vpc.VPC.id
  cidr_block = var.subnet_cidr_block2
  availability_zone       = var.availability_zone2

  tags = {
    Name = "privatesubnet"
  }
}
resource "aws_internet_gateway" "MYIG" {
    vpc_id = aws_vpc.VPC.id

    tags = {
        Name = " My IG"
    }
  
}
resource "aws_route_table" "publicRT" {
    vpc_id = aws_vpc.VPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id  = aws_internet_gateway.MYIG.id
    }  
}
resource "aws_route_table" "privRT" {
    vpc_id = aws_vpc.VPC.id
    route {
        cidr_block = "0.0.0.0/0"
    }  
}
resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.publicRT.id
  gateway_id     = aws_internet_gateway.MYIG.id

}
resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.sub2
  route_table_id = aws_route_table.privRT.id
}

resource "aws_security_group" "example_sg" {
  name = "app1-sG"
  description = "Security group for EC2 instances"

  ingress {
   from_port = 22
   to_port = 22
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from any IP
  }
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance "app1" {
  subnet_id = aws_subnet.sub1.ids
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = aws_security_group.example_sg.id
}

resource "aws_ebs_volume" "example" {
  availability_zone = var.availability_zone1
  size              = "40"
}

resource "aws_volume_attachment" "ebs_att"  {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.app1.id  
  root_block_device {
    volume_size = 30 # in GB <<----- I increased this!
    volume_type = "gp3"
    encrypted   = true
    kms_key_id  = data.aws_kms_key.customer_master_key.arn
  }
}
resource "aws_s3_bucket" "myS3" {
  bucket = "Demo-bucket"
}

resource "aws_security_group" "example_sg" {
  name = "ec2-sG"
  ingress {
   from_port = 22
   to_port = 22
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from any IP
  }

 egress {
 from_port = 0
 to_port = 0
 protocol = "-1"
 cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_lb" "my_alb" {
  name               = "APP1-alb",
  load_balancer_type = "application",
  subnets            = aws_subnet.sub1.id,
  security_groups`= aws_security_group.example_sg.id,
  enable_deletion_protection = var.enable_deletion_protection
}

resource "aws_lb_target_group" "my_target_group" {
  name     = "APP1-TG"
  port     = var.target_group_port,
  vpc_id   = aws_vpc.VPC.id,
  slow_start = 0,
  target_type      = "instance",
  protocol         = var.protocol,
  health_check {
    path = "/",
    port = 80,
    healthy_threshold = "6",
    unhealthy_threshold = "2",
    timeout = "2",
    interval = 5,
    matcher = "200"  # has to be HTTP 200 or fails
  }
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = var.listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}
resource "aws_lb_target_group_attachment" "web" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.app1.id
  port             = 80
}

resource "aws_launch_configuration" "example" {
  name                 = "app1-launch-image"
  image_id             = var.ami_id # Replace with your desired AMI ID
  instance_type        = t2.micro              # Replace with your desired instance type
  security_groups      = [aws_security_group.example.id]
  key_name             = "your-key-pair"         # Replace with your SSH key name
  user_data            = "#!/bin/bash\necho 'Hello, World!'" # Replace with your user data script (optional)
}
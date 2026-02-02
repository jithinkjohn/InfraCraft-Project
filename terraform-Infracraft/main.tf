# Terraform-InfraCraft Cost-Optimized Blueprint
# Region: Mumbai (ap-south-1)

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1" 
}

# 1. Network Infrastructure (VPC)
resource "aws_vpc" "infracraft_vpc" {
  cidr_block = "10.0.0.0/16"
  tags       = { Name = "InfraCraft-VPC-Mumbai" }
}

# 2. Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.infracraft_vpc.id
  cidr_block = "10.0.1.0/24"
  tags       = { Name = "InfraCraft-Subnet" }
}

# 3. Application Load Balancer
resource "aws_lb" "infracraft_alb" {
  name               = "infracraft-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_subnet.id]
}

# 4. Auto Scaling Group with Spot Instances
resource "aws_autoscaling_group" "app_asg" {
  name                = "infracraft-asg"
  desired_capacity    = 3
  max_size            = 3 # Kept small to control costs
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.public_subnet.id]

  launch_template {
    id      = aws_launch_template.infracraft_template.id
    version = "$Latest"
  }
}

# 5. Launch Template using t3.micro
resource "aws_launch_template" "infracraft_template" {
  name_prefix   = "infracraft-tpl"
  image_id      = "ami-0dee22c13ea7a9a67"
  instance_type = "t3.micro"              

  instance_market_options {
    market_type = "spot"
  }

  tags = { Name = "InfraCraft-App-Instance" }
}

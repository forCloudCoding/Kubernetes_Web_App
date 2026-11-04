
terraform {
  required_providers {
    aws = {}
  }
}



# Data Source to get the default VPC ID
data "aws_vpc" "default" {
  default = true
}

# Create a security group for Server 1
resource "aws_security_group" "server_1_sg" {
  name        = "server_1-sg"
  description = "Security Group for Server 1"
  vpc_id      = data.aws_vpc.default.id

  #1 Ingress rules for Server 1 - for SSH Login - Accessible By "All"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #2 Ingress rules for Server 1 - for HTTP Access - Accessible By "All"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #3 Ingress rules for Server 1 - for HTTP Access on Port No. 8080 - Accessible By "All"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #4 Ingress rules for Server 1 - for ICMP Access - Accessible By "All"
  ingress {
    description = "Allow all ICMP IPv4 traffic"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict this range in production
  }


  # Default Egress Rule ( Outbound Traffic - all Allowed )
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Tags for the security group
  tags = {
    Name = "server_1-sg"
  }
}

# Create a security group for Client 1
resource "aws_security_group" "client_1_sg" {
  name        = "client_1-sg"
  description = "Security Group for Client 1"
  vpc_id      = data.aws_vpc.default.id

  #1 Ingress rules for Client 1 - for SSH Login - Accessible By "All"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #2 Ingress rules for Client 1 - for HTTP Access - Accessible By "All"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #3 Ingress rules for Client 1 - for HTTP Access on Port No. 8080 - Accessible By "All"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #4 Ingress rules for Client 1 - for ICMP Access - Accessible By "All"
  ingress {
    description = "Allow all ICMP IPv4 traffic"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict this range in production
  }

  # Default Egress Rule ( Outbound Traffic - all Allowed )
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Tags for the security group
  tags = {
    Name = "client_1-sg"
  }
}


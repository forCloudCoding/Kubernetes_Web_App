
terraform {
  required_providers {
    aws = {}
  }
}



# Data Source to get the default VPC ID
data "aws_vpc" "default" {
  default = true
}

# Create a security group for Control Plane
resource "aws_security_group" "control_plane_sg" {
  name        = "control-plane-sg"
  description = "Security Group for Control Plane"
  vpc_id      = data.aws_vpc.default.id

  #1 Ingress rules for Control Plane - Kubernetes API server - Used By "All"
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #2 Ingress rules for Control Plane - etcd server client API - Used By "kube-apiserver & etcd"
  ingress {
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #3 Ingress rules for Control Plane - Kubelet API - Used By "Self & Control plane"
  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #4 Ingress rules for Control Plane - kube-scheduler - Used By "Self"
  ingress {
    from_port   = 10259
    to_port     = 10259
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #5 Ingress rules for Control Plane - kube-controller-manager - Used By "Self"
  ingress {
    from_port   = 10257
    to_port     = 10257
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
    Name = "control-plane-sg"
  }
}

# Create a security group for Worker Nodes
resource "aws_security_group" "worker_nodes_sg" {
  name        = "worker-nodes-sg"
  description = "Security Group for Worker Nodes"
  vpc_id      = data.aws_vpc.default.id

  #1 Ingress rules for Worker Nodes - Kubelet API - Used By "Self & Control Plane"
  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #2 Ingress rules for Worker Nodes - kube-proxy - Used By "Self & Control Plane"
  ingress {
    from_port   = 10256
    to_port     = 10256
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #3 Ingress rules for Worker Nodes - NodePort Services - Used By "All"
  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #4 Ingress rules for Worker Nodes - NodePort Services - Used By "All"
  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
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
    Name = "worker-nodes-sg"
  }
}

